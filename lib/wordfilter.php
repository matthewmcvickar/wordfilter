<?php

  class Wordfilter {
    var $blocklist;

    function __construct() {
      $str = file_get_contents(dirname(__FILE__) . "/badwords.json");
      $this->blocklist = json_decode($str, true);
    }

    function blocklisted($string) {
      $test_string = strtolower($string);
      foreach ($this->blocklist as $badword) {
        if (strpos($test_string, $badword) !== false) {
          return true;
        }
      }

      return false;
    }

    /**
     * @deprecated
     */
    function blacklisted($string) {
      trigger_error('The name of this function has changed to `blocklisted`. Please update your code accordingly.', E_USER_DEPRECATED);
      return $this->blocklisted($string);
    }

    function addWords($words) {
      if (!is_array($words)) {
        $words = array($words);
      }
      foreach ($words as $word) {
        array_push($this->blocklist, strtolower($word));
      }
    }

    function removeWord($word) {
      $this->blocklist = array_diff($this->blocklist, array(strtolower($word)));
    }

    function clearList() {
      $this->blocklist = array();
    }
  }

?>
