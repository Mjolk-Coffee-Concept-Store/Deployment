create table if not exists migrations
(
    id        serial,
    timestamp bigint  not null,
    name      varchar not null,
    constraint "PK_8c82d7f526340ab734260ea46be"
        primary key (id)
);

alter table migrations
    owner to mjolk_dev;

create table if not exists users
(
    id          uuid default uuid_generate_v4() not null,
    username    varchar(50)                     not null,
    password    varchar(255)                    not null,
    permissions integer                         not null,
    full_name   varchar(255)                    not null,
    is_active   boolean                         not null,
    constraint "PK_a3ffb1c0c8416b9fc6f907b7433"
        primary key (id)
);

alter table users
    owner to mjolk_dev;

create table if not exists recommendations
(
    id              uuid default uuid_generate_v4() not null,
    email           varchar(50)                     not null,
    name            varchar(25)                     not null,
    content         varchar(250)                    not null,
    visit_date      date                            not null,
    submission_date date                            not null,
    rating          numeric(2, 1),
    constraint "PK_23a8d2db26db8cabb6ae9d6cd87"
        primary key (id)
);

alter table recommendations
    owner to mjolk_dev;

create table if not exists post_categories
(
    "Id_Categorie" serial,
    name           varchar(50)  not null,
    description    varchar(160) not null,
    slug           varchar(10)  not null,
    constraint "PK_674cec271a55d828a56fe81e79c"
        primary key ("Id_Categorie"),
    constraint "UQ_235ee0669c727771807c7f8d389"
        unique (name),
    constraint "UQ_5e0badd4b72dd5fd52242a4e849"
        unique (slug)
);

alter table post_categories
    owner to mjolk_dev;

create table if not exists posts
(
    "Id_Post"  uuid      default uuid_generate_v4() not null,
    title      varchar(255)                         not null,
    slug       varchar(10)                          not null,
    content    text                                 not null,
    created_at timestamp default now()              not null,
    updated_at timestamp default now(),
    constraint "PK_93a5e245f36ce5395f9df2ce584"
        primary key ("Id_Post"),
    constraint "UQ_54ddf9075260407dcfdd7248577"
        unique (slug)
);

alter table posts
    owner to mjolk_dev;

create table if not exists post_images
(
    "Id_Image" uuid default uuid_generate_v4() not null,
    img_path   varchar(50)                     not null,
    alt_text   varchar(155),
    constraint "PK_a6cbd3ad5d9e41a915b2ad0c4a4"
        primary key ("Id_Image")
);

alter table post_images
    owner to mjolk_dev;

create table if not exists partnership
(
    id                uuid default uuid_generate_v4() not null,
    email             varchar(50)                     not null,
    last_name         varchar(50)                     not null,
    first_name        varchar(50)                     not null,
    phone             varchar(50)                     not null,
    business_sector   varchar(50)                     not null,
    message           text                            not null,
    submission_date   varchar(50)                     not null,
    attachment_1_path varchar(255),
    attachment_2_path varchar(255),
    attachment_3_path varchar(255),
    constraint "PK_f1bf1be9f475497d8b396d4cc56"
        primary key (id)
);

alter table partnership
    owner to mjolk_dev;

create table if not exists logs
(
    id         serial,
    level      varchar(50)  not null,
    category   varchar(50)  not null,
    short_msg  varchar(255) not null,
    long_msg   text,
    created_at timestamp    not null,
    user_id    varchar(50),
    constraint "PK_fb1b805f2f7795de79fa69340ba"
        primary key (id)
);

alter table logs
    owner to mjolk_dev;

create table if not exists consumables
(
    id            uuid default uuid_generate_v4() not null,
    name          varchar(255)                    not null,
    type          integer                         not null,
    description   text                            not null,
    temperature   varchar(50)                     not null,
    price         numeric(6, 2)                   not null,
    is_vegetarian boolean                         not null,
    is_vegan      boolean                         not null,
    availability  boolean                         not null,
    allergens     varchar(255),
    constraint "PK_88ce43ef80ea7ac74b91dbd8614"
        primary key (id)
);

alter table consumables
    owner to mjolk_dev;

create table if not exists consumables_orders
(
    id              uuid default uuid_generate_v4() not null,
    table_number    integer                         not null,
    submission_date timestamp                       not null,
    completed       boolean                         not null,
    constraint "PK_6416c6f6c99e9c3be84503af51b"
        primary key (id)
);

alter table consumables_orders
    owner to mjolk_dev;

create table if not exists consumables_ordered
(
    "Id_Consumable"        uuid                  not null,
    "Id_Consumables_Order" uuid                  not null,
    served                 boolean default false not null,
    comments               text,
    constraint "PK_4e02f2b098d0ac987edb0e43ccf"
        primary key ("Id_Consumable", "Id_Consumables_Order"),
    constraint "FK_85bb668e6e8287b6abf276d7160"
        foreign key ("Id_Consumable") references consumables,
    constraint "FK_1a4b0f321d89f2276106648d1fc"
        foreign key ("Id_Consumables_Order") references consumables_orders
);

alter table consumables_ordered
    owner to mjolk_dev;

create table if not exists brunchs
(
    id          uuid default uuid_generate_v4() not null,
    name        varchar(255)                    not null,
    description text                            not null,
    constraint "PK_4556981d29ba761d6b141a28b06"
        primary key (id)
);

alter table brunchs
    owner to mjolk_dev;

create table if not exists brunch_items
(
    name          varchar(255)                    not null,
    course        varchar(50)                     not null,
    description   text,
    availability  boolean                         not null,
    is_vegetarian boolean                         not null,
    is_vegan      boolean                         not null,
    allergens     text,
    hidden_price  numeric(10, 2)                  not null,
    id            uuid default uuid_generate_v4() not null,
    "brunchId"    uuid,
    constraint "PK_2922cf952e91aaa95aa5bd37fef"
        primary key (id),
    constraint "FK_8f150a512e52e186b9214fe6187"
        foreign key ("brunchId") references brunchs
);

alter table brunch_items
    owner to mjolk_dev;

create table if not exists brunch_reservations
(
    customer_name         varchar(50)                        not null,
    customer_email        varchar(50)                        not null,
    customer_phone        varchar(10)                        not null,
    company_name          varchar(50),
    reservation_date      timestamp                          not null,
    number_of_people      smallint                           not null,
    created_at            timestamp                          not null,
    table_number          integer,
    order_submission_date timestamp,
    ended                 boolean default false              not null,
    id                    uuid    default uuid_generate_v4() not null,
    "brunchId"            uuid,
    constraint "PK_daefde96f2aeaf0a43dfc7d9d95"
        primary key (id),
    constraint "FK_1c42cab982db2068e526e8e342c"
        foreign key ("brunchId") references brunchs
);

alter table brunch_reservations
    owner to mjolk_dev;

create table if not exists brunch_orders_items
(
    served          boolean default false              not null,
    comments        text,
    id              uuid    default uuid_generate_v4() not null,
    "reservationId" uuid,
    "itemId"        uuid,
    constraint "PK_0042a2cc3d64a74e8f4f3f16d7b"
        primary key (id),
    constraint "FK_fbcb4c77e782c146cd5f9f17d9e"
        foreign key ("reservationId") references brunch_reservations,
    constraint "FK_fa5debf4cab71ca82d6acd3a67f"
        foreign key ("itemId") references brunch_items
);

alter table brunch_orders_items
    owner to mjolk_dev;

create table if not exists posts_categories
(
    "Id_Post"      uuid    not null,
    "Id_Categorie" integer not null,
    constraint "PK_9aec6bbf7bf33ba49ab88631239"
        primary key ("Id_Post", "Id_Categorie"),
    constraint "FK_c2612475f737182409fac254ecb"
        foreign key ("Id_Post") references posts
            on update cascade on delete cascade,
    constraint "FK_7e98a356f4e626e03cef72c7371"
        foreign key ("Id_Categorie") references post_categories
);

alter table posts_categories
    owner to mjolk_dev;

create index if not exists "IDX_c2612475f737182409fac254ec"
    on posts_categories ("Id_Post");

create index if not exists "IDX_7e98a356f4e626e03cef72c737"
    on posts_categories ("Id_Categorie");

create table if not exists posts_images
(
    "Id_Post"  uuid not null,
    "Id_Image" uuid not null,
    constraint "PK_09f6f0b50f9431679d46745700f"
        primary key ("Id_Post", "Id_Image"),
    constraint "FK_6af4e0d6f9ad506b016573301ff"
        foreign key ("Id_Post") references posts
            on update cascade on delete cascade,
    constraint "FK_4a4a50317b3dafe110958113cf8"
        foreign key ("Id_Image") references post_images
);

alter table posts_images
    owner to mjolk_dev;

create index if not exists "IDX_6af4e0d6f9ad506b016573301f"
    on posts_images ("Id_Post");

create index if not exists "IDX_4a4a50317b3dafe110958113cf"
    on posts_images ("Id_Image");

create table if not exists brunch_orders_consumables
(
    served          boolean default false              not null,
    comments        text,
    id              uuid    default uuid_generate_v4() not null,
    "reservationId" uuid,
    "consumableId"  uuid,
    constraint "PK_f5c6cf610c6c79f42c87dc8e4c8"
        primary key (id),
    constraint "FK_2479bbe3893e84bd4ee20d005cb"
        foreign key ("reservationId") references brunch_reservations,
    constraint "FK_192d2724deed1086980b862bbe6"
        foreign key ("consumableId") references consumables
);

alter table brunch_orders_consumables
    owner to mjolk_dev;

