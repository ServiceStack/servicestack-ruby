# frozen_string_literal: true

require_relative 'test_helper'

class FileUploadsTest < Minitest::Test
  include TestHelper

  def test_posts_file_with_request
    body = nil
    content_type = nil
    stub_request(:post, "#{BASE_URL}/api/TestFileUploads")
      .with { |req|
        body = req.body.dup
        content_type = req.headers['Content-Type']
        true
      }
      .to_return(body: { refId: 'Holiday', files: [{ name: 'file', fileName: 'photo.png' }] }.to_json)

    res = client.post_file_with_request(
      TestFileUploads.new(ref_id: 'Holiday'),
      ServiceStack::UploadFile.new(field_name: 'file', file_name: 'photo.png',
                                   content_type: 'image/png', stream: 'PNG-CONTENTS')
    )

    assert_instance_of TestFileUploadsResponse, res
    assert_equal 'Holiday', res.ref_id
    assert_instance_of UploadInfo, res.files.first
    assert_equal 'photo.png', res.files.first.file_name
    assert_match %r{^multipart/form-data; boundary=----ServiceStackFormBoundary}, content_type

    # Request DTO properties are sent as form fields, using their wire names
    assert_includes body, 'Content-Disposition: form-data; name="refId"'
    assert_includes body, 'Holiday'

    # Files are sent with their filename and Content-Type
    assert_includes body, 'Content-Disposition: form-data; name="file"; filename="photo.png"'
    assert_includes body, 'Content-Type: image/png'
    assert_includes body, 'PNG-CONTENTS'
  end

  def test_posts_multiple_files
    body = nil
    stub_request(:post, "#{BASE_URL}/api/TestFileUploads")
      .with { |req| body = req.body.dup; true }
      .to_return(body: { refId: 'Holiday' }.to_json)

    client.post_files_with_request(TestFileUploads.new(ref_id: 'Holiday'), [
      ServiceStack::UploadFile.new(field_name: 'file1', file_name: 'a.txt', stream: 'AAA'),
      ServiceStack::UploadFile.new(field_name: 'file2', file_name: 'b.txt', stream: 'BBB')
    ])

    assert_includes body, 'filename="a.txt"'
    assert_includes body, 'filename="b.txt"'
    assert_includes body, 'AAA'
    assert_includes body, 'BBB'
    # Files without a Content-Type default to application/octet-stream
    assert_includes body, 'Content-Type: application/octet-stream'
  end

  def test_uploads_io_streams
    body = nil
    stub_request(:post, "#{BASE_URL}/api/TestFileUploads")
      .with { |req| body = req.body.dup; true }
      .to_return(body: '{}')

    require 'stringio'
    client.post_file_with_request(
      TestFileUploads.new,
      ServiceStack::UploadFile.new(file_name: 'stream.txt', stream: StringIO.new('IO-CONTENTS'))
    )

    assert_includes body, 'IO-CONTENTS'
    # Defaults to a 'file' field name
    assert_includes body, 'name="file"; filename="stream.txt"'
  end

  def test_raises_web_service_exception_on_failed_upload
    stub_request(:post, "#{BASE_URL}/api/TestFileUploads")
      .to_return(status: [400, 'Bad Request'],
                 body: error_body('NotEmpty', "'RefId' must not be empty.", 'RefId'))

    error = assert_raises(ServiceStack::WebServiceException) do
      client.post_file_with_request(TestFileUploads.new,
                                    ServiceStack::UploadFile.new(file_name: 'a.txt', stream: 'A'))
    end

    assert_equal 400, error.status_code
    assert_equal "'RefId' must not be empty.", error.field_error('RefId')
  end
end
