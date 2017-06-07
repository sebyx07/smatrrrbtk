// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'

class Chart extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      currency: 'btc',
      timeSpan: '30',
      values: []
    };
  }

  componentDidMount(){
    window.$.post('/currencies', {currency: this.state.currency, time_span: this.state.timeSpan}).then((values) => {
      this.setState('values', values);
    });
  }

  render () {
    return <p> Hello React!</p>;
  }
}


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
      <Chart/>,
      document.body.appendChild(document.createElement('div')),
  )
});
