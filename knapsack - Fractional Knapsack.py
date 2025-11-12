class Item:
    def __init__(self, value, weight):
        self.value = value
        self.weight = weight
        self.ratio = value / weight  # Value-to-weight ratio

def fractional_knapsack(capacity, items):
    # Sort items by value-to-weight ratio in descending order
    items.sort(key=lambda x: x.ratio, reverse=True)

    total_value = 0.0

    for item in items:
        if capacity == 0:
            break
        if item.weight <= capacity:
            total_value += item.value
            capacity -= item.weight
        else:
            # Take the fraction of the item that fits
            fraction = capacity / item.weight
            total_value += item.value * fraction
            capacity = 0  # Knapsack is full

    return total_value

n = int(input("Enter number of items: "))
items = []

print("Enter value and weight of each item:")
for _ in range(n):
    value, weight = map(int, input().split())
    items.append(Item(value, weight))

capacity = int(input("Enter capacity of knapsack: "))

max_value = fractional_knapsack(capacity, items)

print(f"\nMaximum value in Knapsack = {max_value}")
