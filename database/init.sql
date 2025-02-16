create table if not exists migrations
(
    id        serial
        constraint "PK_8c82d7f526340ab734260ea46be"
            primary key,
    timestamp bigint  not null,
    name      varchar not null
);

create table if not exists users
(
    "Id_User"   uuid default uuid_generate_v4() not null
        constraint "PK_8152d8f10e5af5e45141527e92f"
            primary key,
    username    varchar(50)                     not null,
    password    varchar(255)                    not null,
    permissions integer                         not null,
    full_name   varchar(255)                    not null,
    is_active   boolean                         not null
);

create table if not exists recommendations
(
    "Id_Recommendation" uuid default uuid_generate_v4() not null
        constraint "PK_587b68f65f86383691649d179c9"
            primary key,
    email               varchar(50)                     not null,
    name                varchar(25)                     not null,
    content             varchar(250)                    not null,
    visit_date          date                            not null,
    submission_date     date                            not null,
    rating              numeric(2, 1)
);

create table if not exists post_categories
(
    "Id_Categorie" serial
        constraint "PK_674cec271a55d828a56fe81e79c"
            primary key,
    name           varchar(50)  not null
        constraint "UQ_235ee0669c727771807c7f8d389"
            unique,
    description    varchar(160) not null,
    slug           varchar(10)  not null
        constraint "UQ_5e0badd4b72dd5fd52242a4e849"
            unique
);

create table if not exists posts
(
    "Id_Post"  uuid      default uuid_generate_v4() not null
        constraint "PK_93a5e245f36ce5395f9df2ce584"
            primary key,
    title      varchar(255)                         not null,
    slug       varchar(10)                          not null
        constraint "UQ_54ddf9075260407dcfdd7248577"
            unique,
    content    text                                 not null,
    created_at timestamp default now()              not null,
    updated_at timestamp default now()
);

create table if not exists post_images
(
    "Id_Image" uuid default uuid_generate_v4() not null
        constraint "PK_a6cbd3ad5d9e41a915b2ad0c4a4"
            primary key,
    img_path   varchar(50)                     not null,
    alt_text   varchar(155)
);

create table if not exists partnership
(
    "Id_Partnership"  uuid default uuid_generate_v4() not null
        constraint "PK_94c9a4659826fd4bbd29fce2b7b"
            primary key,
    email             varchar(50)                     not null,
    last_name         varchar(50)                     not null,
    first_name        varchar(50)                     not null,
    phone             varchar(50)                     not null,
    business_sector   varchar(50)                     not null,
    message           text                            not null,
    submission_date   varchar(50)                     not null,
    attachment_1_path varchar(255),
    attachment_2_path varchar(255),
    attachment_3_path varchar(255)
);

create table if not exists logs
(
    "Id_Log"   serial
        constraint "PK_2d10ed9ec221096532badec8191"
            primary key,
    level      varchar(50)  not null,
    category   varchar(50)  not null,
    short_msg  varchar(255) not null,
    long_msg   text,
    created_at timestamp    not null,
    user_id    varchar(50)
);

create table if not exists consumables
(
    "Id_Consumable" uuid default uuid_generate_v4() not null
        constraint "PK_ea2bbccbc8fa955b5b54939f7b1"
            primary key,
    name            varchar(255)                    not null,
    type            integer                         not null,
    description     text                            not null,
    temperature     varchar(50)                     not null,
    price           numeric(6, 2)                   not null,
    is_vegetarian   boolean                         not null,
    is_vegan        boolean                         not null,
    availability    boolean                         not null,
    allergens       varchar(255)
);

create table if not exists consumables_orders
(
    "Id_Consumables_Order" uuid default uuid_generate_v4() not null
        constraint "PK_77f3a0ff88395f3caee8edeae34"
            primary key,
    table_number           integer                         not null,
    submission_date        timestamp                       not null
);

create table if not exists consumables_ordered
(
    "Id_Consumable"        uuid    not null
        constraint "FK_85bb668e6e8287b6abf276d7160"
            references consumables,
    "Id_Consumables_Order" uuid    not null
        constraint "FK_1a4b0f321d89f2276106648d1fc"
            references consumables_orders,
    quantity               integer not null,
    constraint "PK_4e02f2b098d0ac987edb0e43ccf"
        primary key ("Id_Consumable", "Id_Consumables_Order")
);

create table if not exists brunchs
(
    "Id_Brunch" uuid default uuid_generate_v4() not null
        constraint "PK_90d60ac93b99ed51626959acbe9"
            primary key,
    name        varchar(255)                    not null,
    description text                            not null
);

create table if not exists brunch_items
(
    "Id_Brunch_item" uuid default uuid_generate_v4() not null
        constraint "PK_7827cb97f3008e596719b5ee368"
            primary key,
    name             varchar(255)                    not null,
    course           varchar(50)                     not null,
    description      text,
    availability     boolean                         not null,
    is_vegetarian    boolean                         not null,
    is_vegan         boolean                         not null,
    allergens        text,
    hidden_price     numeric(10, 2)                  not null,
    "brunchIdBrunch" uuid
        constraint "FK_86e890601aeb771568f15184dd8"
            references brunchs
);

create table if not exists brunch_reservations
(
    "Id_Brunch_reservation" uuid default uuid_generate_v4() not null
        constraint "PK_99a7463298feb5825746cd054a6"
            primary key,
    customer_name           varchar(50)                     not null,
    customer_email          varchar(50)                     not null,
    customer_phone          varchar(10)                     not null,
    company_name            varchar(50),
    reservation_date        timestamp                       not null,
    number_of_people        smallint                        not null,
    created_at              timestamp                       not null,
    table_number            integer
);

create table if not exists brunch_orders_items
(
    "Id_Brunch_item"                 uuid    not null,
    "Id_Brunch_Order"                uuid    not null,
    quantity                         integer not null,
    "reservationIdBrunchReservation" uuid
        constraint "FK_1110187d817d2bc0a4edaabd9dd"
            references brunch_reservations,
    "itemIdBrunchItem"               uuid
        constraint "FK_d69e5053b396f3c05d072ff12e1"
            references brunch_items,
    constraint "PK_d3300044ebe702dd4005bd05748"
        primary key ("Id_Brunch_item", "Id_Brunch_Order")
);

create table if not exists posts_categories
(
    "Id_Post"      uuid    not null
        constraint "FK_c2612475f737182409fac254ecb"
            references posts
            on update cascade on delete cascade,
    "Id_Categorie" integer not null
        constraint "FK_7e98a356f4e626e03cef72c7371"
            references post_categories,
    constraint "PK_9aec6bbf7bf33ba49ab88631239"
        primary key ("Id_Post", "Id_Categorie")
);

create index if not exists "IDX_c2612475f737182409fac254ec"
    on posts_categories ("Id_Post");

create index if not exists "IDX_7e98a356f4e626e03cef72c737"
    on posts_categories ("Id_Categorie");

create table if not exists posts_images
(
    "Id_Post"  uuid not null
        constraint "FK_6af4e0d6f9ad506b016573301ff"
            references posts
            on update cascade on delete cascade,
    "Id_Image" uuid not null
        constraint "FK_4a4a50317b3dafe110958113cf8"
            references post_images,
    constraint "PK_09f6f0b50f9431679d46745700f"
        primary key ("Id_Post", "Id_Image")
);

create index if not exists "IDX_6af4e0d6f9ad506b016573301f"
    on posts_images ("Id_Post");

create index if not exists "IDX_4a4a50317b3dafe110958113cf"
    on posts_images ("Id_Image");

create table if not exists brunch_orders_consumables
(
    "Id_Consumable"                  uuid    not null,
    "Id_Brunch_Order"                uuid    not null,
    quantity                         integer not null,
    "reservationIdBrunchReservation" uuid
        constraint "FK_e9d690c1d68b1fbe40f295ee299"
            references brunch_reservations,
    "consumableIdConsumable"         uuid
        constraint "FK_ef938bc030d01fc73e973754f69"
            references consumables,
    constraint "PK_42594b3962c4e25f7ef9866dd6b"
        primary key ("Id_Consumable", "Id_Brunch_Order")
);

