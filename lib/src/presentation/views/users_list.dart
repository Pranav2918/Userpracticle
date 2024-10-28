import 'package:exubixpractical/src/data/user_model.dart';
import 'package:exubixpractical/src/domain/db_services.dart';
import 'package:exubixpractical/src/domain/network_services.dart';
import 'package:exubixpractical/src/presentation/views/user_details.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  final String _searchQuery = '';
  bool _isLoading = true; // Flag to manage loading state
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  Future<void> _loadUsers() async {
    _users = await getUsersFromHive();

    if (_users.isEmpty) {
      _users.clear();
      _users = await ApiServices().fetchUsers();
      await storeUsers(_users);
    }
    _filterUsers(_searchQuery);
    setState(() {
      _isLoading = false;
    });
  }

  void _filterUsers(String query) {
    final query = _searchController.text.toLowerCase();
    _filteredUsers.clear();
    _filteredUsers = _users
        .where((user) => user.varDrName.toLowerCase().contains(query))
        .toSet()
        .toList();
    setState(() {});
  }

  void _navigateToDetails(User user) async {
    final updatedUser = await Navigator.of(context).push<User>(
      MaterialPageRoute(
        builder: (context) => UserDetails(user: user),
      ),
    );

    if (updatedUser != null) {
      // Update the list with the modified user
      final index =
          _users.indexWhere((u) => u.varDrReqCode == updatedUser.varDrReqCode);
      if (index != -1) {
        _users[index] = updatedUser;
        _filterUsers(_searchController.text); // Refresh the filtered list
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 196, 230),
        title: const Text("Employee List"),
        actions: [
          IconButton(
              onPressed: () async {
                await ApiServices().fetchUsers();
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              style: searchTextStyle,
              onChanged: (value) => _filterUsers(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: "Search...",
                hintStyle: hintStyle,
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: _isLoading // Show loading indicator while fetching
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _filteredUsers.isEmpty
                    ? const Center(child: Text("No user found"))
                    : ListView.builder(
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _navigateToDetails(_filteredUsers[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 10.0),
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 5.0,
                                    height: 60.0,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0))),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _filteredUsers[index].varDrName,
                                          style: nameStyle,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${_filteredUsers[index].varCategory} | ",
                                              style: detailStyle,
                                            ),
                                            Text(
                                              "${_filteredUsers[index].varSpeciality} | ",
                                              style: detailStyle,
                                            ),
                                            Text(
                                              _filteredUsers[index].varCity,
                                              style: detailStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
