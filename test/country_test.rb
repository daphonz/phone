require File.dirname(__FILE__) + '/test_helper'

class CountryPhoneDataTest < Test::Unit::TestCase
  def test_parse_germany_local
    pn = Validate::Phone.parse('+49 714 1605832')    

    assert_equal pn.country_code, '49'
    assert_equal pn.area_code, '714'
    assert_equal pn.number, '1605832'
  end
  
  def test_parse_germany_mobile
    pn = Validate::Phone.parse('+49 162 3499558')

    assert_equal pn.country_code, '49'
    assert_equal pn.area_code, '162'
    assert_equal pn.number, '3499558'
  end  
  
  def test_parse_hungary_mobile
    pn = Validate::Phone.parse('+36 30 5517999')    

    assert_equal pn.country_code, '36'
    assert_equal pn.area_code, '30'
    assert_equal pn.number, '5517999'
  end  
  
  def test_parse_slovenia_local
    #Maribor
    pn = Validate::Phone.parse '+ 386 2 23 46 611'
    
    assert_equal pn.country_code, '386'
    assert_equal pn.area_code, '2'
    assert_equal pn.number, '2346611'    
  end
  
  def test_parse_slovenia_local_2
    # Koper
    pn = Validate::Phone.parse '+ 386 5 23 46 611'
    
    assert_equal pn.country_code, '386'
    assert_equal pn.area_code, '5'
    assert_equal pn.number, '2346611'    
  end  
  
  def test_parse_slovenia_mobile
    # Mobitel
    pn = Validate::Phone.parse('+386 51 258999')    

    assert_equal pn.country_code, '386'
    assert_equal pn.area_code, '51'
    assert_equal pn.number, '258999'
  end
  
  def test_parse_serbia_local
    # Beograd
    pn = Validate::Phone.parse('+381 11 24 33 836')

    assert_equal pn.country_code, '381'
    assert_equal pn.area_code, '11'
    assert_equal pn.number, '2433836'
  end
  
  
  def test_parse_serbia_mobile
    # mts
    pn = Validate::Phone.parse('+381 648542987')

    assert_equal pn.country_code, '381'
    assert_equal pn.area_code, '64'
    assert_equal pn.number, '8542987'
  end  
  
  def test_parse_bosnia_local
    pn = Validate::Phone.parse '+387 33 25 02 33'
    
    assert_equal pn.country_code, '387'
    assert_equal pn.area_code, '33'
    assert_equal pn.number, '250233'    
  end

  def test_parse_south_africa_local
    # Telkom
    pn = Validate::Phone.parse('+27 11 555 5555')

    assert_equal pn.country_code, '27'
    assert_equal pn.area_code, '11'
    assert_equal pn.number, '5555555'
  end

  def test_parse_south_africa_mobile
    # Vodacom
    pn = Validate::Phone.parse('+27 82 555 5555')

    assert_equal pn.country_code, '27'
    assert_equal pn.area_code, '82'
    assert_equal pn.number, '5555555'
  end

  def test_parse_south_africa_tollfree
    # Telkom
    pn = Validate::Phone.parse('+27 800 123 321')

    assert_equal pn.country_code, '27'
    assert_equal pn.area_code, '800'
    assert_equal pn.number, '123321'
  end
end
