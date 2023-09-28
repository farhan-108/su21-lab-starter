#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    node *fast_ptr = head, *slow_ptr = head;
    if (head == NULL) {
        return 0;
    }
    while (fast_ptr->next) {
        fast_ptr = fast_ptr->next;
        if (fast_ptr->next) {
            fast_ptr = fast_ptr->next;
        }
        slow_ptr = slow_ptr -> next;
        if (slow_ptr == fast_ptr) {
            return 1;
        }
    }
    return 0;
}
