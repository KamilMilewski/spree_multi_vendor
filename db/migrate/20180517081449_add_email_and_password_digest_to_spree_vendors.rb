class AddEmailAndPasswordDigestToSpreeVendors < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_vendors, :email, :string, unique: true
    add_column :spree_vendors, :password_digest, :string

    add_index :spree_vendors, :email
  end
end
