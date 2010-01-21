require File.dirname(__FILE__) + '/test_helper'

class Validate::PhoneTest < Test::Unit::TestCase
  
  def test_number_without_country_code_initialize    
    Validate::Phone.default_country_code = nil
    
    assert_raise RuntimeError do
      pn = Validate::Phone.new '5125486', '91'
    end
  end
  
  def test_number_without_country_and_area_code_initialize    
    Validate::Phone.default_country_code = nil
    Validate::Phone.default_area_code = nil    
    
    assert_raise RuntimeError do
      pn = Validate::Phone.new '451588'
    end
  end  
  
  def test_number_with_default_area_code_initialize    
    Validate::Phone.default_country_code = '385'
    Validate::Phone.default_area_code = '47'    
    
    pn = Validate::Phone.new '451588'
    assert pn.number == '451588'
    assert pn.area_code == '47'    
    assert pn.country_code == '385' 
  end    
  
  def test_number_with_default_country_code_initialize
    Validate::Phone.default_country_code = '386'
    
    pn = Validate::Phone.new '5125486', '91'
    assert pn.number == '5125486'
    assert pn.area_code == '91'    
    assert pn.country_code == '386'    
  end  
  
  def test_number_with_country_code_initialize
    Validate::Phone.default_country_code = '387'
    
    pn = Validate::Phone.new '5125486', '91', '385'
    assert pn.number == '5125486'
    assert pn.area_code == '91'
    assert pn.country_code == '385'
  end  
  
  def test_parse_empty
    assert_equal Validate::Phone.parse(''), nil
    assert_equal Validate::Phone.parse(nil), nil
  end
  
  def test_parse_long_without_special_characters
    pn = Validate::Phone.parse "+385915125486"
    
    assert_equal pn.number, '5125486'
    assert_equal pn.area_code, '91'
    assert_equal pn.country_code, '385'    
  end
  
  def test_parse_zagreb_long_without_special_characters
    pn = Validate::Phone.parse "+38513668734"
    
    assert_equal pn.number, '3668734'
    assert_equal pn.area_code, '1'
    assert_equal pn.country_code, '385'    
  end  
  
  def test_parse_long_with_special_characters
    pn = Validate::Phone.parse "+ 385 (91) 512 / 5486 "
    
    assert pn.number == '5125486'
    assert pn.area_code == '91'
    assert pn.country_code == '385'    
  end  
  
  def test_parse_long_with_leading_zeros
    pn = Validate::Phone.parse "00385915125486"
    
    assert pn.number == '5125486'
    assert pn.area_code == '91'
    assert pn.country_code == '385'    
  end  
  
  def test_parse_zagreb_long_with_leading_zeros
    pn = Validate::Phone.parse "0038513668734"
    
    assert pn.number == '3668734'
    assert pn.area_code == '1'
    assert pn.country_code == '385'    
  end     
  
  def test_parse_short_without_special_characters_without_country
    Validate::Phone.default_country_code = nil
     
    assert_raise RuntimeError do   
      pn = Validate::Phone.parse "0915125486"
    end
  end  
  
  def test_parse_short_without_special_characters_with_country
    Validate::Phone.default_country_code = '385'
        
    pn = Validate::Phone.parse "044885047"
    
    assert_equal pn.number, '885047'
    assert_equal pn.area_code, '44'
    assert pn.country_code == '385'
  end  
  
  def test_parse_zagreb_short_without_special_characters_with_country
    Validate::Phone.default_country_code = '385'
        
    pn = Validate::Phone.parse "013668734"
    
    assert_equal pn.number, '3668734'
    assert_equal pn.area_code, '1'
    assert_equal pn.country_code, '385'
  end     
  
  def test_parse_short_with_special_characters_without_country
    Validate::Phone.default_country_code = nil
        
    assert_raise RuntimeError do
      pn = Validate::Phone.parse "091/512-5486"
    end
  end      
  
  def test_parse_long_with_zero_in_brackets
    Validate::Phone.default_country_code = nil
    
    pn = Validate::Phone.parse '+385 (0)1 366 8111'    
    assert_equal pn.country_code, '385'
    assert_equal pn.area_code, '1'
    assert_equal pn.number, '3668111'
  end
  
  
  
  def test_to_s
    Validate::Phone.default_country_code = nil    
    pn = Validate::Phone.new '5125486', '91', '385'
    assert pn.to_s == '+385915125486'
  end  
  
  def test_to_s_without_country_code
    Validate::Phone.default_country_code = '385'   
    pn = Validate::Phone.new '5125486', '91'
    assert pn.format("0%a%n") == '0915125486'
  end
  
  def test_format_special_with_country_code
    Validate::Phone.default_country_code = nil    
    pn = Validate::Phone.new '5125486', '91', '385'
    assert pn.format("+ %c (%a) %n") == '+ 385 (91) 5125486'
  end  
  
  def test_format_special_without_country_code
    Validate::Phone.default_country_code = '385'    
    pn = Validate::Phone.new '5125486', '91'
    assert_equal pn.format("%A/%f-%l"), '091/512-5486'
  end  
  
  def test_format_with_symbol_specifier
    Validate::Phone.default_country_code = nil    
    pn = Validate::Phone.new '5125486', '91', '385'
    assert_equal pn.format(:europe), '+385 (0) 91 512 5486'
  end    
  
  def test_doesnt_validate
    assert_equal Validate::Phone.valid?('asdas'), false
    assert_equal Validate::Phone.valid?('385915125486'), false
  end
  
  def test_validates
    Validate::Phone.default_country_code = nil
    assert_equal Validate::Phone.valid?('00385915125486'), true                    
    assert_equal Validate::Phone.valid?('+385915125486'), true
    assert_equal Validate::Phone.valid?('+385 (91) 512 5486'), true                  
    assert_equal Validate::Phone.valid?('+38547451588'), true            

    Validate::Phone.default_country_code = '385'    
    assert_equal Validate::Phone.valid?('0915125486'), true
    assert_equal Validate::Phone.valid?('091/512-5486'), true
    assert_equal Validate::Phone.valid?('091/512-5486'), true
    assert_equal Validate::Phone.valid?('091 512 54 86'), true    
    assert_equal Validate::Phone.valid?('091-512-54-86'), true    
    assert_equal Validate::Phone.valid?('047/451-588'), true    
  end
  
  def test_has_default_country_code
    Validate::Phone.default_country_code = '385'
    
    assert_equal Validate::Phone.parse('+38547451588').has_default_country_code?, true
    assert_equal Validate::Phone.parse('+38647451588').has_default_country_code?, false
  end
  
  def test_has_default_area_code
    Validate::Phone.default_country_code = '385'    
    Validate::Phone.default_area_code = '47'
    
    assert_equal Validate::Phone.parse('047/451-588').has_default_area_code?, true
    assert_equal Validate::Phone.parse('032/336-1456').has_default_area_code?, false
  end  
end
