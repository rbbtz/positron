import React from 'react'
import ReactDOM from 'react-dom'
import _ from 'underscore'
import set from 'lodash.set'
import styled from "styled-components"
import { Flex, Box } from 'reflexbox'
// import { Grid, Col, Row } from 'react-styled-flexboxgrid'
import DropdownHeader from 'client/apps/edit/components/admin/components/dropdown_header.coffee'
import ImageUpload from 'client/apps/edit/components/admin/components/image_upload.coffee'
import CharacterLimitInput from 'client/components/character_limit/index.coffee'

const Title = styled.h1`
  font-size: 1.5em;
  text-align: center;
  color: palevioletred;
`;

class PromotedAdmin extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      curation: props.curation,
      saveStatus: "Save"
    }
  }

  onImageInputChange(name, url, i) {
    return this.onChange(name, url, i)
  }

  onInputChange(e, i) {
    return this.onChange(e.target.name, e.target.value, i)
  }

  onChange(key, value, index) {
    const newCuration = this.state.curation.clone()
    const section = newCuration.get('sections')[index]
    set(section, key, value)

    return this.setState({curation: newCuration, saveStatus: "Save"})
  }

  save() {
    return this.state.curation.save({}, {
      success: () => this.setState({saveStatus: "Saved"}),
      error: error => this.setState({saveStatus: "Error"})
    })
  }

  render() {
    return (
      <div>
        {
          _.map(this.state.curation.get('sections'), (section, index) =>
            <Flex p={2} align='center' key={index}>
              <Box px={2} w={1/2}>
                <Title className="promoted-admin__container admin-form-container" key={`promoted-admin-${index}`}>
                  aaa
                </Title>
              </Box>
              <Box px={2} w={1/2}>
                <Title className="promoted-admin__container admin-form-container" key={`promoted-admin-${index}`}>
                  aaa
                </Title>
              </Box>
            </Flex>
          )
        }
      </div>
    )
  }
}

export default PromotedAdmin
