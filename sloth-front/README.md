# Sloth Project

![version](https://img.shields.io/badge/version-1.0.0-blue.svg) ![author](https://img.shields.io/badge/author-Jaune1605-blue.svg) 
![Sloth Project](https://github.com/Jaune1605/Sloth/blob/42f87ecc3060ca33f7ad83d6a752e9f68fb8a54d/sloth-front/src/assets/img/sloth-banner.png?raw=true)

### Sloth: An Essential IT Automation and Management Tool for Every Business

Sloth revolutionizes IT management, making it effortlessly manageable for any enterprise. This comprehensive tool automates ticket resolutions through advanced AI technologies, allowing for swift and efficient handling of IT support issues directly through an intuitive admin dashboard. For tickets that require manual intervention, the dashboard provides seamless management capabilities, ensuring no issue goes unresolved.

Beyond ticket resolution, Sloth excels in the automated provisioning of virtual machines (VMs). From initiation to installation, the entire process is automated, providing businesses with a hands-off approach to managing their virtual resources. The admin dashboard serves as a central hub for overseeing all VM operations, including resource allocation, basic installations, and overall management, streamlining the IT infrastructure setup and maintenance tasks.

Sloth empowers any enterprise with the tools to manage IT elements effortlessly, enhancing operational efficiency and reducing manual workload. Whether it’s resolving support tickets via AI or managing a fleet of VMs, Sloth provides a robust platform that caters to all your IT management needs.


### Get Started

- Install NodeJS LTS version from the official website.
- Clone the repository and navigate to the `sloth-front` directory.
- Run `npm run install:clean` to install dependencies.
- (If not) Run `npm start` to start the development server.
- (If not) Run `npm run build:tailwind` to build the application with Tailwind CSS.
- Navigate to `http://localhost:4200` to see the application in action.

### Core Features

- **AI-Powered Ticket Solver:** Access the AI solver with a simple client account, allowing for automated resolution of IT support tickets.
![Solver](https://github.com/Jaune1605/Sloth/blob/23bcc27b7ed10b00166a63e238e460a0a6dbe165/sloth-front/src/assets/img/solver.png?raw=true)
- **Administration Dashboard:** Provision and manage virtual machines directly through the dashboard. This feature automates the setup and management of VMs, making it easier for IT administrators to handle infrastructure needs.
![Dashboard](https://github.com/Jaune1605/Sloth/blob/23bcc27b7ed10b00166a63e238e460a0a6dbe165/sloth-front/src/assets/img/dashboard.png?raw=true)
- **Ticket Management:** Handle unresolved tickets efficiently. The administration dashboard provides tools to manage open tickets, ensuring that all issues are addressed promptly and effectively.
![Opened Tickets](https://github.com/Jaune1605/Sloth/blob/23bcc27b7ed10b00166a63e238e460a0a6dbe165/sloth-front/src/assets/img/ticket_opened.png?raw=true)

### Pages

Sloth provides essential pages needed for effective project management:
- **Dashboard** for managing all IT operations.
- **Solver** (chat) for AI-powered ticket resolution.
- **Landing** page for a quick overview of the project.
- **Login and registration** pages for user authentication with **Keycloak**.
- Other pages, components and utilities are described in the Folder section below.

## Table of Contents

* [Versions](#versions)
* [Documentation](#documentation)
* [Quick Start](#quick-start)
* [Files and folders](#files-and-folders)
* [Reporting Issues](#reporting-issues)
* [Useful Links](#useful-links)

## Versions

| Tailwind CSS | Angular | Node.js |
|:---:|:---:|:---:|
| [![Tailwind CSS](https://github.com/Jaune1605/Sloth/blob/ee3253d7328846f08b69993a8ff3d4e56695c26b/sloth-front/src/assets/img/tailwind.png?raw=true)](https://tailwindcss.com/docs/installation) | [![Angular](https://github.com/Jaune1605/Sloth/blob/be36f0e35f7eeceeb0f6d70d43588538ca5abeee/sloth-front/src/assets/img/angular.png?raw=true)](https://angular.io/docs) | [![Node.js](https://github.com/Jaune1605/Sloth/blob/ee3253d7328846f08b69993a8ff3d4e56695c26b/sloth-front/src/assets/img/node.png?raw=true)](https://nodejs.org/en/docs/) |
| V2 | 17 | 20.12.1 (LTS) |


## Documentation
The documentation for Sloth is available in the project repository. Refer to `sloth-front/README.md` for front-end specific details and `sloth-back/README.md` for back-end configurations.
`README.md` contains genral project information for both parts.

## Quick Start

- <a href="https://github.com/Jaune1605/Sloth.git?target=_blank">Clone the repository</a> and navigate to the `sloth-front`
-  <a href="http://10.19.4.2:8080/admin/master/console/#/realms/External/users?_=_&client=account&realm=External" target="_blank">Export Keycloak</a> to get access to the entire front-end.

## Files and Folders

```
sloth-front
.
├── README.md
├── angular.json
├── e2e
│   ├── protractor.conf.js
│   ├── src
│   │   ├── app.e2e-spec.ts
│   │   └── app.po.ts
│   └── tsconfig.json
├── karma.conf.js
├── package.json
├── src
│   ├── app
│   │   ├── app-routing.module.ts
│   │   ├── app.component.html
│   │   ├── app.component.ts
│   │   ├── app.module.ts
│   │   ├── components
│   │   │   ├── cards
│   │   │   │   ├── card-bar-chart
│   │   │   │   │   ├── card-bar-chart.component.html
│   │   │   │   │   └── card-bar-chart.component.ts
│   │   │   │   ├── card-line-chart
│   │   │   │   │   ├── card-line-chart.component.html
│   │   │   │   │   └── card-line-chart.component.ts
│   │   │   │   ├── card-settings
│   │   │   │   │   ├── card-settings.component.html
│   │   │   │   │   └── card-settings.component.ts
│   │   │   │   ├── card-stats
│   │   │   │   │   ├── card-stats.component.html
│   │   │   │   │   └── card-stats.component.ts
│   │   │   │   └── card-table
│   │   │   │       ├── card-table.component.html
│   │   │   │       └── card-table.component.ts
│   │   │   ├── dropdowns
│   │   │   │   └── table-dropdown
│   │   │   │       ├── table-dropdown.component.html
│   │   │   │       └── table-dropdown.component.ts
│   │   │   ├── footers
│   │   │   │   ├── footer
│   │   │   │   │   ├── footer.component.html
│   │   │   │   │   └── footer.component.ts
│   │   │   │   ├── footer-admin
│   │   │   │   │   ├── footer-admin.component.html
│   │   │   │   │   └── footer-admin.component.ts
│   │   │   │   └── footer-small
│   │   │   │       ├── footer-small.component.html
│   │   │   │       └── footer-small.component.ts
│   │   │   ├── headers
│   │   │   │   └── header-stats
│   │   │   │       ├── header-stats.component.html
│   │   │   │       └── header-stats.component.ts
│   │   │   ├── navbars
│   │   │   │   ├── admin-navbar
│   │   │   │   │   ├── admin-navbar.component.html
│   │   │   │   │   └── admin-navbar.component.ts
│   │   │   │   └── auth-navbar
│   │   │   │       ├── auth-navbar.component.html
│   │   │   │       └── auth-navbar.component.ts
│   │   │   ├── servers
│   │   │   │   ├── aws-form
│   │   │   │   │   ├── aws-form.component.html
│   │   │   │   │   ├── aws-form.component.css
│   │   │   │   │   ├── aws-form.component.spec.ts
│   │   │   │   │   └── aws-form.component.ts
│   │   │   │   ├── proxmox-form
│   │   │   │   │   ├── proxmox-form.component.html
│   │   │   │   │   ├── proxmox-form.component.css
│   │   │   │   │   ├── proxmox-form.component.spec.ts
│   │   │   │   │   └── proxmox-form.component.ts
│   │   │   │   └──  server-infos
│   │   │   │       ├── server-infos.component.html
│   │   │   │       ├── server-infos.component.css
│   │   │   │       ├── server-infos.component.spec.ts
│   │   │   │       └── server-infos.component.ts
│   │   │   └── sidebar
│   │   │       ├── sidebar.component.html
│   │   │       └── sidebar.component.ts
│   │   ├── layouts
│   │   │   ├── admin
│   │   │   │   ├── admin.component.html
│   │   │   │   └── admin.component.ts
│   │   │   └── auth
│   │   │       ├── auth.component.html
│   │   │       └── auth.component.ts
│   │   ├── guards
│   │   │   ├── admin.guard.ts
│   │   │   └── auth.guard.ts
│   │   ├── services
│   │   │   ├── server
│   │   │   │   └── service.service.ts
│   │   │   ├── validators
│   │   │   │   ├── validator.service.ts
│   │   │   │   └── validator.service.spec.ts
│   │   │   └── apiIA.service.ts
│   │   │   
│   │   └── views
│   │       ├── admin
│   │       │   ├── configure-page
│   │       │   │   ├── configure-page.component.html
│   │       │   │   ├── configure-page.component.ts
│   │       │   │   ├── configure-page.component.spec.ts
│   │       │   │   └── configure-page.component.css
│   │       │   ├── create-server-form
│   │       │   │   ├── create-server-form.component.html
│   │       │   │   ├── create-server-form.component.ts
│   │       │   │   ├── create-server-form.component.spec.ts
│   │       │   │   └── create-server-form.component.css
│   │       │   ├── dashboard
│   │       │   │   ├── dashboard.component.html
│   │       │   │   └── dashboard.component.ts
│   │       │   ├── infrasturcture-page
│   │       │   │   ├── infrasturcture-page.component.html
│   │       │   │   ├── infrasturcture-page.component.ts
│   │       │   │   ├── infrasturcture-page.component.spec.ts
│   │       │   │   └── infrasturcture-page.component.css
│   │       │   ├── settings
│   │       │   │   ├── settings.component.html
│   │       │   │   └── settings.component.ts
│   │       │   └── tables
│   │       │       ├── tables.component.html
│   │       │       └── tables.component.ts
│   │       ├── auth
│   │       │   ├── login
│   │       │   │   ├── login.component.html
│   │       │   │   └── login.component.ts
│   │       │   └── register
│   │       │       ├── register.component.html
│   │       │       └── register.component.ts
│   │       ├── landing
│   │       │   ├── landing.component.html
│   │       │   └── landing.component.ts
│   │       └── solver
│   │           ├── solver.component.html
│   │           └── solver.component.ts
│   ├── assets
│   │   ├── img
│   │   └── styles
│   │       ├── index.css
│   │       └── tailwind.css
│   ├── environments
│   │   ├── environment.prod.ts
│   │   └── environment.ts
│   ├── favicon.ico
│   ├── SlothLogo.ico
│   ├── index.html
│   ├── main.ts
│   ├── polyfills.ts
│   ├── styles.css
│   └── test.ts
├── tailwind.config.js
├── tsconfig.app.json
├── tsconfig.json
├── tsconfig.spec.json
└── tslint.json
```

## Useful Links

- [Project Repository](https://github.com/Jaune1605/Sloth)
- [Issue Tracker](https://github.com/Jaune1605/Sloth/issues)

## Resources
- Demo (localhost): [Live Preview](http://localhost:4200)
- Source: [GitHub Repository](https://github.com/Jaune1605/Sloth)
- Support: [Contact Us](https://github.com/Jaune1605/Sloth/issues)
