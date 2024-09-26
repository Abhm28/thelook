# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Status" in Explore.

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: completeyesno {
    type: yesno
    sql: CASE
         WHEN (
           ${TABLE}.status = 'COMPLETED'
         )
         THEN TRUE
         ELSE FALSE
       END ;;
  }
  dimension: days_remaining_in_quarter {
    type: number
    sql:
    CASE
      WHEN EXTRACT(MONTH FROM CURRENT_DATE()) IN (1, 2, 3) THEN
        DATEDIFF(DATE(CONCAT(YEAR(CURRENT_DATE()), '-03-31')), CURRENT_DATE())
      WHEN EXTRACT(MONTH FROM CURRENT_DATE()) IN (4, 5, 6) THEN
        DATEDIFF(DATE(CONCAT(YEAR(CURRENT_DATE()), '-06-30')), CURRENT_DATE())
      WHEN EXTRACT(MONTH FROM CURRENT_DATE()) IN (7, 8, 9) THEN
        DATEDIFF(DATE(CONCAT(YEAR(CURRENT_DATE()), '-09-30')), CURRENT_DATE())
      WHEN EXTRACT(MONTH FROM CURRENT_DATE()) IN (10, 11, 12) THEN
        DATEDIFF(DATE(CONCAT(YEAR(CURRENT_DATE()), '-12-31')), CURRENT_DATE())
    END ;;
    description: "The number of days remaining in the current quarter, including today."
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.first_name,
  users.last_name,
  billion_orders.count,
  fakeorders.count,
  hundred_million_orders.count,
  hundred_million_orders_wide.count,
  order_items.count,
  order_items_vijaya.count,
  ten_million_orders.count
  ]
  }

}
