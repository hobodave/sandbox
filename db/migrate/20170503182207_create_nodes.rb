class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :nodes, id: false do |t|
      t.uuid :id, primary: true, default: 'uuid_generate_v4()'
      t.text :metadata

      t.timestamps
    end

    execute 'ALTER TABLE ONLY nodes ADD CONSTRAINT nodes_pkey PRIMARY KEY (id)'
  end
end
