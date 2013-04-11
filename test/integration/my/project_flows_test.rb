require 'test_helper'

class My::ProjectFlowsTest < ActionDispatch::IntegrationTest

	test "there is a my projects link in the nav bar" do
		get_signed_in_user
		visit "/"

	assert find('.navbar').has_link?('My Projects')
	end

	#broken
	test "the my projects link is not there when i log out" do
		visit "/"
		assert_false find('.navbar').has_link?('My Projects')
	end

	test "the my projects link is active when I visit the my projects page" do
		get_signed_in_user #makes sure you are logged in first
		visit my_projects_url
		assert_equal find("ul.nav li.active a").text, "My Projects"
	end

	#broken
	test "the my projects page lists all of my projects" do
		user = get_signed_in_user
		5.times { FactoryGirl.create(:project, :user => user)}
		other_user = FactoryGirl.create(:user)
		3.times { FactoryGirl.create(:project, :user => other_user, :title => "Not my project")}
		
		visit my_projects_url

		assert page.has_no_content?("Not my project")
	end

	#broken
	test "the my projects page has a link to new project" do
		get_signed_in_user
		visit '/my/projects'
		assert page.has_link?('Create My New Project')
	end

	test "the create btn on my projects pages goes to my projects new" do
		get_signed_in_user
		visit '/my/projects'
		click_link "Create My New Project"
		assert_equal new_my_project_path, current_path
	end

	test "the create btn on the my project page will create new project in database" do
		get_signed_in_user
		visit '/my/projects/new'

		project = FactoryGirl.build(:project)	
		fill_in "project[title]", :with => project.title
		fill_in "project[teaser]", :with => project.teaser
		fill_in "project[description]", :with => project.description
		fill_in "project[goal]", :with => project.goal

		click_button "Create This Project"

		assert_page.has_content?("Project Saved!")
		puts "#{Project.count} !!!!!!!!!!!"
	end


end
