React = require 'react'
ReactDOM = require 'react-dom'
{ div, label, input } = React.DOM

module.exports = React.createClass
  displayName: 'CharacterLimitInput'

  getInitialState: ->
    remainingChars: @props.limit - @props.defaultValue.length

  onInputChange: (e) ->
    remainingChars = @props.limit - e.target.value.length
    @setState remainingChars: remainingChars
    @props.onChange(e)

  render: ->
    fieldTag = @props.tag || input

    div {},
      label {}, @props.label
      div {}, @state.remainingChars
      fieldTag {
        className: 'bordered-input'
        placeholder: @props.placeholder
        defaultValue: @props.defaultValue
        onChange: @onInputChange
        name: @props.name
        maxLength: @props.limit
      }
