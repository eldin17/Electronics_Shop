import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { firstValueFrom } from 'rxjs';

import { OrderItem } from '../../components/order-item/order-item';
import { AuthService } from '../../services/auth.service';
import { UserAccountService } from '../../services/user.account.service';
import { OrderService } from '../../services/order.service';
import { Order } from '../../models/order/order';
import { SearchOrder } from '../../models/order/search.order';

@Component({
  selector: 'app-orders',
  standalone: true,
  imports: [CommonModule, OrderItem],
  templateUrl: './orders.html',
  styleUrl: './orders.css',
})
export class Orders implements OnInit {
  orders: Order[] = [];
  selectedOrder: Order | null = null;

  isLoading = true;
  errorMessage = '';

  constructor(
    private authService: AuthService,
    private userAccountService: UserAccountService,
    private orderService: OrderService,
    private router: Router,
  ) {}

  async ngOnInit(): Promise<void> {
    const userAccId = this.authService.getUserId();
    if (!userAccId) {
      this.isLoading = false;
      this.errorMessage = 'You must be logged in to view orders.';
      return;
    }

    try {
      const userAcc = await firstValueFrom(this.userAccountService.getById(userAccId));
      const customerId = (userAcc as any).customer?.id;

      if (!customerId) {
        this.isLoading = false;
        this.errorMessage = 'No customer profile found for this account.';
        return;
      }

      const search: SearchOrder = { customerId } as SearchOrder;
      const result = await firstValueFrom(this.orderService.getAll(search));

      this.orders = (result.data ?? [])
        .slice()
        .sort((a: any, b: any) => (b.id ?? 0) - (a.id ?? 0));

      this.selectedOrder = this.orders[0] ?? null;
    } catch (err) {
      console.error('Failed to load orders', err);
      this.errorMessage = 'Could not load your orders.';
    } finally {
      this.isLoading = false;
    }
  }

  selectOrder(order: Order): void {
    this.selectedOrder = order;
  }

  get isSelectedPending(): boolean {
    return (this.selectedOrder as any)?.stateMachine === 'Pending';
  }

  get selectedDisplayTotal(): number | undefined {
    return (this.selectedOrder as any)?.finalTotalAmount ?? (this.selectedOrder as any)?.totalAmount;
  }

  async payNow(): Promise<void> {
    if (!this.selectedOrder) return;
    const orderId = (this.selectedOrder as any).id;

    try {
      await firstValueFrom(this.orderService.backToDraft(orderId));
      this.router.navigate(['/payment-methods', orderId]);
    } catch (err) {
      console.error('Failed to prepare order for payment', err);
    }
  }

  goBack(): void {
    this.router.navigate(['/home']);
  }
}
