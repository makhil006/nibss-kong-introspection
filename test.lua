print("===> Hello World!")

local cjson = require "cjson"

local json = '{"sub":"bXiNVxpC9UEkyGMHkARtvRpKEBj5C021Qbzx8856L7Q","iss":"https://id.sandbox.nibss-plc.com.ng","active":true,"session_id":"oxId=81a3a7a0-09c1-43f6-bbb5-34578473ece9,ou=sessions,o=gluu","token_type":"bearer","client_id":"b0a65563-cd21-43fe-be86-fb359f50dbe7","aud":"b0a65563-cd21-43fe-be86-fb359f50dbe7","user_id":"22222222303","scope":"address banking_data mobile_phone profile contact_info email","acr_values":"otp","exp":1657778372,"iat":1657778072,"jti":null,"bvn_data":["street_address","zoneinfo","gender","imageDetailsId","state_of_origin","formatted","watchlisted","date_of_birth","face_image","accountDetailId","phone_mobile_number","lga_of_origin","landmarks","lga_of_residence","nin","updated_at","surname","branch_name","nickname","enroll_agency","first_name","email","state_of_residence","website","email_verified","lga_of_capture","state_of_capture","profile","locality","enroll_user_name","middle_name","enroll_bank_code",null,"marital_status","nationality","additional_info_1","name","phone_number","postal_code","region","customer_id","serial_no","enrollment_date","remarks","name_on_card"],"username":"22222222303"}'

print ('===> json string : '..json)

local decoded = cjson.decode(json)

print ('===> json encoded string : '..decoded)