module Wowr
  module API
    module Login
      # Logs the user into the armory using their main world of warcraft username, password and authenticator if given/required.
      # Uses SSL to send details to the login page. Both must be set to true in order to recieve the long life cookie as the second value.
      #
      # short = api.login("username", "password")
      # short, long = api.login("username", "password", nil, true)
      #
      def login(username, password, authenticator = nil, both = false)
        # Create the base URL we will be POSTing to.
        authentication_url = base_url(@locale, {:secure => true, :login => true}) + @@login_url + "?app=armory"

        # Ensure we add the correct bounce point.
        if (@locale == "www")
          authentication_url += "&ref=http://www.wowarmory.com/index.xml"
        else
          authentication_url += "&ref=http://#{@locale}.wowarmory.com/index.xml"
        end

        # Ensure we have no final stage.
        redirectstage = nil

        # Post the first stage
        stage1 = login_http(authentication_url, true, nil, { 'accountName' => username, 'password' => password }, true)

        # Check what happened.
        if (stage1.code == "200")
          # We didn't pass, but we didn't fail yet if we need an authenticator.
          stage1doc = Hpricot.XML(stage1.body)

          # Check to see if our details were incorrect.
          if (stage1doc.at("tas:accountName")['error'])
            # We have had an error returned to us with regards to our username or password.
            raise Wowr::Exceptions::InvalidLoginDetails
          end

          # Okey do we require an authenticator?
          if (!stage1doc.at("tas:authType")['value'] || stage1doc.at("tas:authType")['value'] != "BA")
            # Ummm, we're not invalid nor do we have no clue about the authType required now.
            raise Wowr::Exceptions::LoginBroken
          end

          # Do we have an authenticator code to use?
          raise Wowr::Exceptions::LoginRequiresAuthenticator if (!authenticator)

          stage1cookie = nil

          # Get the *authentication sites* JSESSIONID.
          stage1.header['set-cookie'].scan(/JSESSIONID=(.*?);/) {
            stage1cookie = $1
          }

          # Let's post the authenticator and the session for this login.
          stage2 = login_http(authentication_url, true, { 'JSESSIONID' => stage1cookie }, { 'authValue' => authenticator }, true)

          # So now we check what happened.
          if (stage2.code == "200")
            # This isn't a good sign, we should have redirected now.
            stage2doc = Hpricot.XML(stage2.body)

            # Error is obvious
            if (stage2doc.at("tas:accountName")['error'])
              # We have had an error returned to us with regards to our username or password.
              raise Wowr::Exceptions::InvalidLoginDetails
            end

            # Error isn't obvious, we can't continue.
            raise Wowr::Exceptions::LoginBroken
          elsif (stage2.code == "302")
            redirectstage = stage2
          end
        elsif (stage1.code == "302")
          redirectstage = stage1
        end

        # We should have been redirected by now.
        if (!redirectstage)
          raise Wowr::Exceptions::LoginBroken
        end

        # Time to obtain our next URL and our long term cookie.
        long_cookie = nil

        redirectstage.header['set-cookie'].scan(/#{@@persistent_cookie}=(.*?);/) {
          long_cookie = $1
        }

        # Let's bounce to our page that will give us our short term cookie, URL has Kerbrose style ticket.
        short_cookie = login_final_bounce(redirectstage.header['location'])

        # So what does the user want?
        if (both)
          return short_cookie, long_cookie
        else
          return short_cookie
        end
      end

      # Reobtains a short term cookie by using the given long life cookie.
      def refresh_login(long_life_cookie)
        # Create the base URL we will be POSTing to.
        authentication_url = base_url(@locale, {:secure => true, :login => true}) + @@login_url + "?app=armory"

        # Ensure we add the correct bounce point.
        if (@locale == "www")
          authentication_url += "&ref=http://www.wowarmory.com/index.xml"
        else
          authentication_url += "&ref=http://#{@locale}.wowarmory.com/index.xml"
        end

        # All we need to do is goto the armory login page passing our long life cookie, we should get 302 instantly.
        stage1 = login_http(authentication_url, true, { @@persistent_cookie => long_life_cookie })

        # Let's see
        if (stage1.code == "200")
          # It's no good, our cookie doesn't work anymore.
          raise Wowr::Exceptions::InvalidLoginDetails
        elsif (stage1.code == "302")
          # Let's bounce to our page that will give us our short term cookie, URL has Kerbrose style ticket.
          return login_final_bounce(stage1.header['location'])
        end

        # Finally we didn't get 302 or 200?
        raise Wowr::Exceptions::LoginBroken
      end
    end
  end
end
