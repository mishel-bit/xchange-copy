module SessionHelpers
    def sign_up_with(email, password, password_confirmation)
        visit sign_up_path
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        fill_in 'Confirm Password', with: password_confirmation
        click_on('Create Account')
    end

    def sign_in_with(user)
        visit sign_in_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on('Login to your account')
    end
end
