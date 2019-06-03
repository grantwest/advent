defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "parse ipv7" do
    assert Day7.parse_ipv7("abba[mnop]qrst") == %{supernets: ["abba", "qrst"], hypernets: ["mnop"]}
    assert Day7.parse_ipv7("abba[mnop]bb[cc]qrst") == %{supernets: ["abba", "bb", "qrst"], hypernets: ["mnop", "cc"]}
  end

  test "detects abba" do
    assert Day7.abba?("abba") == true
    assert Day7.abba?("cddc") == true
    assert Day7.abba?("asdf") == false
    assert Day7.abba?("") == false
    assert Day7.abba?("a") == false
    assert Day7.abba?("aa") == false
    assert Day7.abba?("aaa") == false
    assert Day7.abba?("aaaa") == false

    assert Day7.abba?("zabba") == true
    assert Day7.abba?("abbaz") == true
    assert Day7.abba?("asdfz") == false
  end

  test "detects TLS" do
    assert Day7.tls?(Day7.parse_ipv7("abba[mnop]qrst")) == true
    assert Day7.tls?(Day7.parse_ipv7("abcd[bddb]xyyx")) == false
    assert Day7.tls?(Day7.parse_ipv7("aaaa[qwer]tyui")) == false
    assert Day7.tls?(Day7.parse_ipv7("ioxxoj[asdfgh]zxcvbn")) == true
  end

  test "part1" do
    assert Day7.part1() == 110
  end

  ## Part 2 ## 
  test "find aba's" do
    assert Day7.aba("aba") == ["aba"]
    assert Day7.aba("abab") == ["aba", "bab"]
    assert Day7.aba("cdc") == ["cdc"]
    assert Day7.aba("asdf") == []
    assert Day7.aba("") == []
    assert Day7.aba("a") == []
    assert Day7.aba("aa") == []
    assert Day7.aba("aaa") == []

    assert Day7.aba("zaba") == ["aba"]
    assert Day7.aba("abaz") == ["aba"]
    assert Day7.aba("asdfz") == []
  end

  test "convert aba to bab" do
    assert Day7.aba_to_bab("aba") == "bab"
  end

  test "detects SSL" do
    assert Day7.ssl?(Day7.parse_ipv7("aba[bab]xyz")) == true
    assert Day7.ssl?(Day7.parse_ipv7("xyx[xyx]xyx")) == false
    assert Day7.ssl?(Day7.parse_ipv7("aaa[kek]eke")) == true
    assert Day7.ssl?(Day7.parse_ipv7("zazbz[bzb]cdb")) == true
  end

  test "part2" do
    assert Day7.part2() == 242
  end
end
