import { Component, OnInit, inject } from "@angular/core";
import { OidcSecurityService } from 'angular-auth-oidc-client';


@Component({
  selector: "app-sidebar",
  templateUrl: "./sidebar.component.html",
})
export class SidebarComponent implements OnInit {
  private readonly oidcSecurityService = inject(OidcSecurityService);

  collapseShow = "hidden";
  constructor() {}

  ngOnInit() {}
  toggleCollapseShow(classes) {
    this.collapseShow = classes;
  }

  logout() {
    this.oidcSecurityService.logoff().subscribe((result) => console.log(result));
  }
}
