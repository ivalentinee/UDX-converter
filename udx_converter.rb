require 'nokogiri'

filename = ARGV[0]

def udx_file_to_hash(filename)
  File.open(filename) { |file| Nokogiri::XML(file) }
end

def contacts_from_document(document)
  contacts = document.xpath("//DataExchangeInfo/vCard/vCardInfo").map do |contact|
    name = contact.xpath("vCardField/N").text.tr(';', '')
    phone = contact.xpath("vCardField/TEL").text

    { name: name, phone: phone }
  end

  contacts.uniq
end

def write_contacts_text(contacts)
  File.open('contacts.txt', 'w') do |file|
    contacts.each do |contact|
      file.write("#{contact[:name]} : #{contact[:phone]}\n")
    end
  end
end

def write_contacts_vcf(contacts)
  File.open('contacts.vcf', 'w') do |file|
    contacts.each do |contact|
      vcf_record_string = <<~VCF_RECORD
        BEGIN:VCARD
        VERSION:4.0
        N:#{contact[:name]}
        FN:#{contact[:name]}
        TEL;VALUE=uri:tel:#{contact[:phone]}
        END:VCARD
      VCF_RECORD

      file.write("#{vcf_record_string}\n")
    end
  end
end

document = udx_file_to_hash(filename)
contacts = contacts_from_document(document)
write_contacts_text(contacts)
write_contacts_vcf(contacts)
