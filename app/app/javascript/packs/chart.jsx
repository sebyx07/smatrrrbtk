// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'

class Chart extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      currency: 'BTC',
      timeSpan: '365',
      values: []
    };
  }

  componentDidMount(){
    this.getCurrencyValues();
  }

  setCurrency(currency){
    this.setState({currency: currency});
    this.getCurrencyValues();
  }

  setTimeSpan(timeSpan){
    this.setState({timeSpan: timeSpan});
    this.getCurrencyValues();
  }

  getCurrencyValues(){
    const self = this;
    window.$.post('/currencies', {currency: this.state.currency.toLowerCase(), time_span: this.state.timeSpan}).then((resp) => {
      let formattedValues = [];
      const data = resp['data'];

      for(let v in data){
        const unixDate = data[v].date * 1000;
        const date = new Date(unixDate);
        const utcDate = Date.UTC(date.getUTCFullYear(),date.getUTCMonth()-1,date.getUTCDate());

        formattedValues.push([utcDate, data[v].value]);
      }
      this.setState({values: formattedValues});
      self.renderChart();
    }).fail((error) => {
      alert(error.responseJSON.error);
    });
  }

  renderChart(){
    window.Highcharts.chart('chart', {
      chart: {
        type: 'spline'
      },
      title: {
        text: `${this.state.currency} value compared to USD for ${this.state.timeSpan} days`
      },
      xAxis: {
        type: 'datetime',
        title: {
          text: 'Date'
        }
      },
      yAxis: {
        title: {
          text: 'USD value'
        },
        min: 0
      },
      tooltip: {
        headerFormat: `<b>${this.state.currency}</b><br>`,
      },

      plotOptions: {
        spline: {
          marker: {
            enabled: true
          }
        }
      },

      series: [{
        name: `${this.state.currency}`,
        data: this.state.values
      }]
    });
  }

  render () {
    const chart = <div id="chart"></div>;
    const currencyButtons = [],
      timeSpanButtons = [];
    ['BTC', 'ETH'].forEach((currency) => {
      currencyButtons.push(<button key={currency}
                                   className="btn btn-primary"
                                   onClick={this.setCurrency.bind(this, currency)}>
                                      {currency}
                                   </button>)
    });

    ['30', '365'].forEach((timeSpan) => {
      timeSpanButtons.push(<button key={timeSpan}
                                   className="btn btn-success"
                                   onClick={this.setTimeSpan.bind(this, timeSpan)}>
                                     {timeSpan} days
                                   </button>)
    });
    return <div className="container">
      {chart}
      <div className="controls">
        <div className="btn-group">
          {currencyButtons}
        </div>
        <br/>
        <div className="btn-group">
          {timeSpanButtons}
        </div>
      </div>
    </div>
  }
}


document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
      <Chart/>,
      document.body.appendChild(document.createElement('div')),
  )
});
