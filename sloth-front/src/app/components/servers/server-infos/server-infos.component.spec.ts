import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ServerInfosComponent } from './server-infos.component';

describe('ServerInfosComponent', () => {
  let component: ServerInfosComponent;
  let fixture: ComponentFixture<ServerInfosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ServerInfosComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ServerInfosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
