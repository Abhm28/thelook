
view: view1 {
  derived_table: {
    sql: SELECT
          products.category  AS `products.category`,
          COUNT(DISTINCT products.id ) AS `products.count`
      FROM demo_db.inventory_items  AS inventory_items
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
      GROUP BY
          1
      ORDER BY
          2 DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_category {
    type: string
    sql: ${TABLE}.`products.category` ;;
  }

  dimension: products_count {
    type: number
    sql: ${TABLE}.`products.count` ;;
  }

  set: detail {
    fields: [
        products_category,
	products_count
    ]
  }
}
