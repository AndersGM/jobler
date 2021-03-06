require "rails_helper"

describe "jobs" do
  let(:job) { create :job }
  let(:redirect_job) { create :job, jobler_type: "TestRedirectToJob", state: "completed" }
  let(:redirect_job_result) { create :result, job: redirect_job, name: "render", result: "test-result" }

  describe "#show" do
    it "renders the page" do
      visit job_path(job)

      expect(page).to have_http_status :success
      expect(page).to have_current_path job_path(job), ignore_query: true
    end

    it "redirects and uses the apps render mechanism" do
      redirect_job_result

      visit job_path(redirect_job)

      expect(page).to have_http_status :success
      expect(page).to have_current_path "/jobler_jobs/#{redirect_job.to_param}", ignore_query: true
    end
  end
end
