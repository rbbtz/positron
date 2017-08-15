React = require 'react'
ReactDOM = require 'react-dom'
_ = require 'underscore'
set = require 'lodash.set'
{ Grid, Col, Row } = React.createFactory require 'react-styled-flexboxgrid'
{ div, h3, label, input, button, select, option, textarea } = React.DOM
dropdownHeader = React.createFactory require '../../../edit/components/admin/components/dropdown_header.coffee'
ImageUpload = React.createFactory require '../../../edit/components/admin/components/image_upload.coffee'
CharacterLimitInput = React.createFactory require '../../../../components/character_limit/index.coffee'

module.exports = React.createClass
  displayName: 'PromotedAdmin'

  getInitialState: ->
    curation: @props.curation
    saveStatus: "Save"

  onImageInputChange: (name, url, i) ->
    @onChange name, url, i

  onInputChange: (e, i) ->
    @onChange e.target.name, e.target.value, i

  onChange: (key, value, index) ->
    newCuration = @state.curation.clone()
    section = newCuration.get('sections')[index]
    set section, key, value
    @setState curation: newCuration, saveStatus: "Save"

  save: ->
    @state.curation.save {},
      success: =>
        @setState saveStatus: "Saved"
      error: (error) =>
        @setState saveStatus: "Error"

  render: ->
    div {},
      _.map @state.curation.get('sections'), (section, i) =>
        div { className: 'promoted-admin__container admin-form-container', key: "promoted-admin-#{i}" },
          dropdownHeader {
            section: section.name
            key: "dropdown-#{i}"
            className: "promoted-admin__section-header"
          }
          div { className: 'promoted-admin__section' },
            Grid {},
              Row {},
                Col { className: 'field-group' },
                  label {},'Title'
                  input {
                    className: 'bordered-input'
                    placeholder: 'Title'
                    defaultValue: section.name
                    onChange: (e) => @onInputChange(e, i)
                    name: 'name'
                  }
                Col { className: 'field-group' },
                  label {},'Start Date'
                  input {
                    type: 'date'
                    className: 'bordered-input'
                    defaultValue: section.start_date
                    name: 'start_date'
                  }
                Col { className: 'field-group' },
                  label {},'End Date'
                  input {
                    type: 'date'
                    className: 'bordered-input'
                    defaultValue: section.end_date
                    name: 'end_date'
                  }
                Col { className: 'field-group' },
                  label {},' Start Date'
                  select {
                    className: 'bordered-input'
                    defaultValue: section.start_date
                    name: 'start_date'
                  },
                    option { value: '0.25' }, '25%'
                    option { value: '0.50' }, '50%'
                    option { value: '0.75' }, '75%'
          div { className: 'promoted-admin__section_title' }, "Panel"
          div { className: 'promoted-admin__section' },
            div { className: 'fields-left'},
              div { className: 'field-group' },
                CharacterLimitInput {
                  label: 'Headline'
                  placeholder: 'Headline'
                  defaultValue: section.panel.headline
                  onChange: (e) => @onInputChange(e, i)
                  name: 'panel.headline'
                  limit: 25
                }
              div { className: 'field-group' },
                CharacterLimitInput {
                  tag: textarea
                  label: 'Body'
                  placeholder: 'Body'
                  defaultValue: section.panel.body
                  onChange: (e) => @onInputChange(e, i)
                  name: 'panel.body'
                  limit: 90
                }
            div { className: 'fields-right'},
              div {className: 'field-group'},
                label {}, "Image"
                ImageUpload {
                  name: 'panel.image'
                  src: section.panel.image
                  onChange: (name, url) => @onImageInputChange(name, url, i)
                  disabled: false
                }
              div {className: 'field-group'},
                label {}, "Logo"
                ImageUpload {
                  name: 'panel.logo'
                  src: section.panel.logo
                  onChange: (name, url) => @onImageInputChange(name, url, i)
                  disabled: false
                }

      button {
        className: 'avant-garde-button'
        onClick: @save
      }, @state.saveStatus
