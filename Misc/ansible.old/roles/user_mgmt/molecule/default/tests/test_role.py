import pytest


def test_group1_exists(host):
    group = host.group("group1")
    assert group.exists


def test_group1_gid(host):
    group = host.group("group1")
    assert group.gid == 1234


def test_user1_exists(host):
    user = host.user("user1")
    assert user.exists


def test_user1_primary_group(host):
    user = host.user("user1")
    assert user.group == "group1"


def test_user1_in_group1(host):
    user = host.user("user1")
    assert "group1" in user.groups


def test_user1_home_exists(host):
    home = host.file("/home/user1")
    assert home.exists
    assert home.is_directory
    assert home.user == "user1"
