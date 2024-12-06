import { LightningElement } from 'lwc';

import resource from '@salesforce/resourceUrl/protfolio_resource'
import svg from '@salesforce/resourceUrl/protfolio_svg'

export default class Portfolio_UserInfo extends LightningElement {

    profilePic

    get phoneSVG(){
        return svg + '#phone';
    }

    renderedCallback(){
        let profilePicUrl = resource + '/images/profpic.png';
        this.profilePic = `background-image:url('${profilePicUrl}')`
        const element=this.template.querySelector(".Profile_Pic")
        element.setAttribute('style',this.profilePic)
    }
}