class DisplayMessages extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        input: '',
        messages: []
      };
    
    // Add handleChange() and submitMessage() methods here
   this.handleChange = this.handleChange.bind(this);
   this.submitMessage = this.submitMessage.bind(this);
    }
  
    handleChange(e){
      this.setState({
        input: e.target.value
      });
    }
  
    submitMessage() {
      this.setState((state) => ({
        messages: [...state.messages, state.input],
        input: ''
      }));
    }
  
    render() {
      const ulMap = this.state.messages.map((message, index) => <li key={index}>{message}</li>);
  
      return (
        <div>
          <h2>Type in a new Message:</h2>
          { /* Render an input, button, and ul below this line */ }
          <input onChange={this.handleChange} value={this.state.input} />
          <button onClick={this.submitMessage}>Add message</button>
          <ul>
           {ulMap}
          </ul>
          { /* Change code above this line */ }
        </div>
      );
    }
  };