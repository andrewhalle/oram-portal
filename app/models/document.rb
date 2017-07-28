class Document < ActiveRecord::Base
    belongs_to :user
    
    mount_uploader :case_document, CaseDocumentUploader
    
end