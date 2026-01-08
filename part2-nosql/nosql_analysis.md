# NoSQL Analysis for FlexiMart Product Catalog

## Section A: Limitations of RDBMS (150 words)

The current relational database design works well for structured and fixed schemas but struggles when handling highly diverse product data. Different product types such as electronics, apparel, and groceries have different attributes. For example, laptops have RAM and processor details, while shoes have size and color. Representing these variations in an RDBMS requires multiple nullable columns or additional tables, leading to complexity and inefficiency.

Frequent schema changes are another limitation. Every time a new product type with new attributes is introduced, the relational schema must be altered, which is time‑consuming and risky in production systems.

Additionally, storing customer reviews in an RDBMS requires separate tables and complex joins. This makes querying reviews along with product data slower and harder to maintain.

---

## Section B: Benefits of MongoDB (150 words)

MongoDB addresses these challenges through its flexible document‑based schema. Each product can store its own attributes without enforcing a fixed structure, allowing different products to have different fields. This flexibility makes MongoDB ideal for managing a diverse product catalog.

MongoDB also supports embedded documents, enabling customer reviews to be stored directly inside the product document. This improves read performance and simplifies queries when retrieving product details along with reviews.

Horizontal scalability is another key advantage. MongoDB can distribute data across multiple servers using sharding, allowing FlexiMart to scale as the product catalog and user base grow.

---

## Section C: Trade-offs (100 words)

One disadvantage of MongoDB is the lack of strict schema enforcement, which can lead to inconsistent data if not managed carefully. Unlike relational databases, MongoDB does not enforce strong constraints such as foreign keys.

Another drawback is that complex transactional operations across multiple collections are more challenging compared to relational databases. For systems requiring strong ACID guarantees across many entities, MySQL may still be a better choice.