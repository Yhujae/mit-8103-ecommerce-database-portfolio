use("fabbyent_nosql");

// Start with an empty orders collection.
db.orders.deleteMany({});

// Insert two sample Fabbyent orders.
db.orders.insertMany([
  {
    orderNumber: "FAB-1001",
    customer: {
      customerId: 1,
      name: "Ada Okafor",
      email: "ada@example.com",
    },
    items: [
      {
        productId: 101,
        productName: "Wireless Headphones",
        quantity: 1,
        unitPrice: 25000,
      },
      {
        productId: 102,
        productName: "Phone Case",
        quantity: 2,
        unitPrice: 5000,
      },
    ],
    totalAmount: 35000,
    status: "Processing",
    delivery: {
      address: "Ikeja, Lagos",
      method: "Standard",
    },
    createdAt: new Date("2026-10-01T10:00:00Z"),
  },
  {
    orderNumber: "FAB-1002",
    customer: {
      customerId: 2,
      name: "Chidi Bello",
      email: "chidi@example.com",
    },
    items: [
      {
        productId: 103,
        productName: "Bluetooth Speaker",
        quantity: 1,
        unitPrice: 18000,
      },
    ],
    totalAmount: 18000,
    status: "Shipped",
    delivery: {
      address: "Wuse, Abuja",
      method: "Express",
    },
    createdAt: new Date("2026-10-03T14:30:00Z"),
  },
]);

// Confirm the total number of orders.
db.orders.countDocuments({});

// Display a summary of each order.
db.orders.find({}, { _id: 0, orderNumber: 1, totalAmount: 1, status: 1 });
