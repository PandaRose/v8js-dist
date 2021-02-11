<?php

$add = function ($a, $b) {
    return $a + $b;
};

$v8 = new V8Js('PHP', array('add' => 'add'));
$result = $v8->executeString('PHP.add(1,2)');

var_dump($result);
