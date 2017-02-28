Deface::Override.new(
	:virtual_path => "spree/layouts/admin",
	:name => "admin-filter-tab",
	:insert_bottom => "[data-hook='admin_tabs']",
	:partial => "spree/admin/hooks/filter_tab",
	:disabled => false
)
