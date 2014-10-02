Given(/^the following orphans exist:$/) do |table|
  table.hashes.each do |hash|
    status = OrphanStatus.find_or_create_by!(name: hash[:status], code: hash[:code])
    original_province = Province.find_or_create_by!(name: hash[:o_province],
                                           code: hash[:o_code])
    current_province = Province.find_or_create_by!(name: hash[:c_province],
                                                    code: hash[:c_code])
    original_address = Address.create(city: hash[:o_city], province: original_province,
                                      neighborhood: hash[:o_hood])
    current_address = Address.create(city: hash[:c_city], province: current_province,
                                     neighborhood: hash[:c_hood])

    orphan = Orphan.new(name: hash[:name],
                        father_name: hash[:father],
                        orphan_status: status,
                        father_date_of_death: hash[:death_date], mother_name: hash[:mother],
                        date_of_birth: hash[:birth_date],
                        contact_number: hash[:contact],
                        original_address: original_address,
                        current_address: current_address,
                        mother_alive: false,
                        gender: 'Female',
                        minor_siblings_count: 0,
                        father_is_martyr: true,
                        father_occupation: 'Some Occupation',
                        father_place_of_death: 'Some Place',
                        father_cause_of_death: 'Some Cause',
                        health_status: 'Some Health Status',
                        schooling_status: 'Some Schooling Status',
                        goes_to_school: true,
                        guardian_name: 'Some Name',
                        guardian_relationship: 'Some Relationship',
                        guardian_id_num: 12345,
                        alt_contact_number: 'Some Contact',
                        sponsored_by_another_org: false,
                        another_org_sponsorship_details: 'Some Details',
                        sponsored_minor_siblings_count: 0,
                        comments: 'Some Comments')

    orphan.save!
  end
end

Then(/^I should see "Orphans" linking to the admin orphans page$/) do
  expect(page).to have_link('Orphans', href: "#{admin_orphans_path}")
end

When(/^I (?:go to|am on) the "([^"]*)" page for orphan "([^"]*)"$/) do |page, orphan_name|
  orphan = Orphan.find_by name: orphan_name
  visit path_to_admin_role(page, orphan.id)
end

Then(/^I should be on the "(.*?)" page for orphan "(.*?)"$/) do |page_name, orphan_name|
  orphan = Orphan.find_by name: orphan_name
  expect(current_path).to eq path_to_admin_role(page_name, orphan.id)
end

