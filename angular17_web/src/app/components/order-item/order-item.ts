import { Component, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Order } from '../../models/order/order';

@Component({
  selector: 'app-order-item',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './order-item.html',
  styleUrl: './order-item.css',
})
export class OrderItem {
  @Input({ required: true }) order!: Order;
  @Input() selected = false;

  @Output() selectOrder = new EventEmitter<Order>();

  get isPending(): boolean {
    return (this.order as any).stateMachine === 'Pending';
  }

  get displayTotal(): number {
    return (this.order as any).finalTotalAmount ?? (this.order as any).totalAmount;
  }

  onClick(): void {
    this.selectOrder.emit(this.order);
  }
}
