view: productgroup {
  derived_table: {
    explore_source: order_items {
      column: department { field: products.department }
      column: count { field: products.count }
      column: category { field: products.category }
    }
  }
  dimension: department {
    description: ""
  }
  dimension: count {
    description: ""
    type: number
  }
  dimension: category {
    description: ""
  }
}
