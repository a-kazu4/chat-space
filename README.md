# DB設計

## users table

| Column     | Type        | Options                             |
|:-----------|:------------|:------------------------------------|
| name       | string      | null:false, unique:true, index:true |
| email      | string      | null:false, unique:true             |
| password   | string      | null:false, unique:true             |

### Association
* has_many :groups, through: members
* has_many :members
* has_many :messages


## groups table

| Column     | Type        | Options                             |
|:-----------|:------------|:------------------------------------|
| name       | string      | null:false, unique:true, index:true |

### Association
* has_many :users, through: members
* has_many :members
* has_many :messages


## messages table

| Column     | Type        | Options                             |
|:-----------|:------------|:------------------------------------|
| body       | text        | index:true                          |
| image      | string      |                                     |
| group_id   | integer     | null:false, unique:true, index:true |
| user_id    | integer     | null:false, unique:true, index:true |

### Association
* belongs_to :group
* belongs_to :user


## members table

| Column     | Type        | Options                             |
|:-----------|:------------|:------------------------------------|
| group_id   | integer     | null:false, unique:true, index:true |
| user_id    | integer     | null:false, unique:true, index:true |

### Association
* belongs_to :group
* belongs_to :user



