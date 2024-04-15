import { Component } from "@angular/core";

import { OAuthService, NullValidationHandler, AuthConfig } from 'angular-oauth2-oidc';

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
})
export class AppComponent {
  title = "angular-dashboard-page";
  constructor(private oauthService: OAuthService) {
    this.configure();
  }
  async ngOnInit() {
    this.configure();
    const isLoggedIn = await this.oauthService.loadDiscoveryDocumentAndTryLogin();
    if(isLoggedIn){
      console.log("Logged in")
      const claims = this.oauthService.getIdentityClaims();
      console.log('claims: ', claims);
      const token = this.oauthService.getAccessToken();
      console.log('token: ', token);
      if (claims && claims['sub']) {
        const userId = claims['sub'];
        const email = claims['email'];
      }
    }
  }

  authConfig: AuthConfig = {
    issuer: 'http://10.19.4.2:8080/realms/External',
    redirectUri: window.location.origin + '/index.html',
    clientId: 'external-client',
    scope: 'email profile roles web-origins',
    responseType: 'code',
    // at_hash is not present in JWT token
    disableAtHashCheck: true,
    showDebugInformation: true,
    requireHttps: false,
  }

  public login() {
    this.configure();
    console.log("login")
    this.oauthService.initLoginFlow();
    console.log("login info ", this.oauthService.initLoginFlow())
  }
  
  public logoff() {
    this.oauthService.logOut();
  }
  
  private configure() {
    this.oauthService.configure(this.authConfig);
    this.oauthService.tokenValidationHandler = new  NullValidationHandler();
    this.oauthService.loadDiscoveryDocumentAndTryLogin();
  }
}
