import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProxmoxFormComponent } from './proxmox-form.component';

describe('ProxmoxFormComponent', () => {
  let component: ProxmoxFormComponent;
  let fixture: ComponentFixture<ProxmoxFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ProxmoxFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ProxmoxFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
