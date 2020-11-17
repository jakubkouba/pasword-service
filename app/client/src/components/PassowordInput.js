import { render } from '@testing-library/react'
import React, { Component } from 'react'

class PasswordInput extends Component {

    checkPasswordStrength(event) {
        fetch('http://localhost:4567/api/v1/password-strength', {
            method: 'POST',
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({"password": event.target.value})
        })
        .then(response => response.json())
        .then(data => console.log(data))
        .catch(error => console.log('Error', error))
    }
    
    render() {
        return (
        <form>
            <label>
            Password:
            <input type="text" placeholder="Enter your password" onKeyUp={this.checkPasswordStrength}/>
            </label>
        </form>
        );
    }
}

export default PasswordInput
