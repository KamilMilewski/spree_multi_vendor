# e-commerce-yossi
class AddShowWebsiteToSpreeVendors < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_vendors, :show_website, :string
    add_index :spree_vendors, :show_website
  end
end
