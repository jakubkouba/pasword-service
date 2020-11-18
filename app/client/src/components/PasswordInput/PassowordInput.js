import { render } from '@testing-library/react'
import React, { Component } from 'react'
import './PasswordInput.css'

class PasswordInput extends Component {

    constructor() {
        super()
        this.state = {password_strength: 'weak'};
    }

    async getPasswordStrength(password) {
        const password_strength_info = await fetch('http://localhost:4567/api/v1/password-strength', {
            method: 'POST',
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({"password": password})
        });
        return password_strength_info.json();
    }

    showPasswordStrength(event) {
        this.getPasswordStrength(event.target.value).then(password_strength_info => {
            this.setState({password_strength: password_strength_info.status})
        });
    }

    render() {
        return (
            <div className="password-strength">
                <div className="password-strength__text">
                    Your password strength is: <span className={this.state.password_strength}>{this.state.password_strength}</span>
                </div>    
                <form>
                    <input type="text" className={this.state.password_strength}  placeholder="Type your password" onKeyUp={this.showPasswordStrength.bind(this)}/>
                </form>
                <p>
                    Strong password should be at least 6 characters long.<br/>
                    Contain numbers, upprecase characters, symbols and<br/> 
                    should be without sequence of same characters (e.g 'ccc', '1111')
                </p>
            </div>
        );
    }
}

export default PasswordInput
