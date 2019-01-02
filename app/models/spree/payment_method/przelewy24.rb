module Spree
  class PaymentMethod::Przelewy24 < PaymentMethod

    preference :p24_id_sprzedawcy, :string
    preference :url, :string, :default => "https://secure.przelewy24.pl/index.php"
    preference :url_transakcja, :string, :default => "https://secure.przelewy24.pl/transakcja.php"
    preference :test_url, :string, :default => "https://sandbox.przelewy24.pl/index.php"
    preference :test_url_transakcja, :string, :default => "https://sandbox.przelewy24.pl/transakcja.php"
    preference :p24_language, :string, :default => "pl"
    preference :crc_key, :string
    preference :test_mode, :boolean, :default => false

    def payment_profiles_supported?
      false
    end

    def p24_amount(amount)
      (amount*100.00).to_i.to_s #total amount * 100
    end

    def post_url
      if preferred_test_mode
        preferred_test_url
      else
        preferred_url
      end
    end

    def transakcja_url
      if preferred_test_mode
        preferred_test_url_transakcja
      else
        preferred_url_transakcja
      end
    end

  end
end
