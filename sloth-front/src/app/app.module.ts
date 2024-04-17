import { BrowserModule } from "@angular/platform-browser";
import { NgModule } from "@angular/core";
import { AuthModule, LogLevel, StsConfigLoader} from 'angular-auth-oidc-client';

import {NgFor, NgIf} from '@angular/common';

import { FormBuilder, FormGroup, FormArray } from '@angular/forms';



import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";

import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


// layouts
import { AdminComponent } from "./layouts/admin/admin.component";
import { AuthComponent } from "./layouts/auth/auth.component";

// admin views
import { DashboardComponent } from "./views/admin/dashboard/dashboard.component";
import { SettingsComponent } from "./views/admin/settings/settings.component";
import { TablesComponent } from "./views/admin/tables/tables.component";
import { CreateServerFormComponent } from "./views/admin/create-server-form/create-server-form.component";
import { InfrastructurePageComponent } from "./views/admin/infrastructure-page/infrastructure-page.component";
import { ConfigurePageComponent } from "./views/admin/configure-page/configure-page.component";


// auth views
import { LoginComponent } from "./views/auth/login/login.component";
import { RegisterComponent } from "./views/auth/register/register.component";

// no layouts views
import { LandingComponent } from "./views/landing/landing.component";
import { ProfileComponent } from "./views/profile/profile.component";

// components for views and layouts

import { AdminNavbarComponent } from "./components/navbars/admin-navbar/admin-navbar.component";
import { AuthNavbarComponent } from "./components/navbars/auth-navbar/auth-navbar.component";
import { CardBarChartComponent } from "./components/cards/card-bar-chart/card-bar-chart.component";
import { CardLineChartComponent } from "./components/cards/card-line-chart/card-line-chart.component";
import { CardPageVisitsComponent } from "./components/cards/card-page-visits/card-page-visits.component";
import { CardSettingsComponent } from "./components/cards/card-settings/card-settings.component";
import { CardSocialTrafficComponent } from "./components/cards/card-social-traffic/card-social-traffic.component";
import { CardStatsComponent } from "./components/cards/card-stats/card-stats.component";
import { CardTableComponent } from "./components/cards/card-table/card-table.component";
import { FooterAdminComponent } from "./components/footers/footer-admin/footer-admin.component";
import { FooterComponent } from "./components/footers/footer/footer.component";
import { FooterSmallComponent } from "./components/footers/footer-small/footer-small.component";
import { HeaderStatsComponent } from "./components/headers/header-stats/header-stats.component";
import { IndexDropdownComponent } from "./components/dropdowns/index-dropdown/index-dropdown.component";
import { TableDropdownComponent } from "./components/dropdowns/table-dropdown/table-dropdown.component";
import { NotificationDropdownComponent } from "./components/dropdowns/notification-dropdown/notification-dropdown.component";
import { SidebarComponent } from "./components/sidebar/sidebar.component";
import { AwsFormComponent } from "./components/servers/aws-form/aws-form.component";
import { ProxmoxFormComponent } from "./components/servers/proxmox-form/proxmox-form.component";
import { ServerInfosComponent } from "./components/servers/server-infos/server-infos.component";
import { ActivatedRoute } from "@angular/router";


@NgModule({
  declarations: [
    AppComponent,
    DashboardComponent,
    CardBarChartComponent,
    CardLineChartComponent,
    IndexDropdownComponent,
    TableDropdownComponent,
    NotificationDropdownComponent,
    SidebarComponent,
    FooterComponent,
    FooterSmallComponent,
    FooterAdminComponent,
    CardPageVisitsComponent,
    CardSettingsComponent,
    CardSocialTrafficComponent,
    CardStatsComponent,
    CardTableComponent,
    HeaderStatsComponent,
    AuthNavbarComponent,
    AdminNavbarComponent,
    AdminComponent,
    AuthComponent,
    SettingsComponent,
    TablesComponent,
    LoginComponent,
    RegisterComponent,
    LandingComponent,
    ProfileComponent,
    CreateServerFormComponent,
    InfrastructurePageComponent,
    ConfigurePageComponent,
    AwsFormComponent,
    ProxmoxFormComponent,
    ServerInfosComponent,
  ],
  imports: [



    NgFor, FormsModule, ReactiveFormsModule, NgIf,BrowserModule, AppRoutingModule,HttpClientModule, AuthModule.forRoot({
    
    config: {
      authority: 'http://10.19.4.2:8080/realms/External',
      redirectUrl: window.location.origin,
      postLogoutRedirectUri: window.location.origin,
      clientId: 'external-client',
      scope: 'email profile roles web-origins',
      responseType: 'id_token token',
      silentRenew: true,
      useRefreshToken: true,
      secureRoutes: ['/api'],
    },
 
  
})],
  bootstrap: [AppComponent],
})
export class AppModule {}
