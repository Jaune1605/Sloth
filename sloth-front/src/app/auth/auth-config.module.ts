import { NgModule } from '@angular/core';
import { AuthModule } from 'angular-auth-oidc-client';


@NgModule({
    imports: [AuthModule.forRoot({
        config: {
            authority: 'http://10.19.4.2:8080/realms/External',
            redirectUrl: window.location.origin,
            postLogoutRedirectUri: window.location.origin,
            clientId: 'external-client',
            scope: 'email profile roles web-origins',
            responseType: 'code',
            silentRenew: false,
            useRefreshToken: true,
            renewTimeBeforeTokenExpiresInSeconds: 30,
        }
      })],
    exports: [AuthModule],
})
export class AuthConfigModule {}
