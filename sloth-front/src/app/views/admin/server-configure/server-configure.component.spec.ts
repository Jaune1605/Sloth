import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ServerConfigureComponent } from './server-configure.component';

describe('ServerConfigureComponent', () => {
  let component: ServerConfigureComponent;
  let fixture: ComponentFixture<ServerConfigureComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ServerConfigureComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ServerConfigureComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
