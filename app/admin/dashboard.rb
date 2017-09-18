ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc {I18n.t("active_admin.dashboard")}

  content title: proc {I18n.t("active_admin.dashboard")} do
    columns do
      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end

      column do
        panel "Number of Users" do
          users = User.all.count(:id)
        end
      end
    end

    columns do
      column do
        panel "Recent Users" do
          table_for User.order("created_at desc").limit(5).each do |_user|
            column(:name)
            column(:provider)
            column(:created_at)
          end
        end
      end
      column do
        panel "Number of users per game" do
          table_for Player do
            column("Game ID=>Users") { Player.group(:game_id).distinct.count(:user_id) }
            # panel "Number of Game Users" do
            # value = Player.group(:game_id).distinct.count(:user_id)
          end
        end
      end
    end

  end
end
