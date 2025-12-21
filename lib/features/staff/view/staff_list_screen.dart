import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_list/staff_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../view_model/bloc_staff_list/staff_list_bloc.dart';
import '../../../../core/models/staff_model/staff_model.dart';
import '../../../../core/models/staff_request_model/staff_request_model.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<StaffListBloc>().add(const StaffListEvent.loadStaffs());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context
            .read<StaffListBloc>()
            .add(const StaffListEvent.loadNextPageStaffs());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddEditDialog(),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Staff'),
      ),
      body: BlocConsumer<StaffListBloc, StaffListState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_, __, ___, status, message) {
              if (message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor:
                        status.isFailure ? Colors.red : Colors.green,
                  ),
                );
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (message) =>
                Center(child: Text(message)),
            loaded: (staffs, _, isPaginating, status, _1) {
              if (staffs.isEmpty) {
                return const Center(child: Text('No staff found'));
              }

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: staffs.length + (isPaginating ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= staffs.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final staff = staffs[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        staff.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(staff.phoneNumber),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: status.isUpdating
                                ? null
                                : () => _openAddEditDialog(staff),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: status.isUpdating
                                ? null
                                : () => _confirmDelete(staff.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _openAddEditDialog([StaffModel? staff]) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(staff == null ? 'Add Staff' : 'Edit Staff'),
        content: _AddEditStaffForm(staff: staff),
      ),
    );
  }

  void _confirmDelete(int staffId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Staff'),
        content: const Text('Are you sure you want to delete this staff?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context
                  .read<StaffListBloc>()
                  .add(StaffListEvent.deleteStaff(staffId));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// ---------------- ADD / EDIT FORM ----------------

class _AddEditStaffForm extends StatefulWidget {
  final StaffModel? staff;

  const _AddEditStaffForm({this.staff});

  @override
  State<_AddEditStaffForm> createState() => _AddEditStaffFormState();
}

class _AddEditStaffFormState extends State<_AddEditStaffForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.staff?.name ?? '');
    _phoneController =
        TextEditingController(text: widget.staff?.phoneNumber ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
     ElevatedButton(
  onPressed: () {
    final request = StaffRequestModel(
      id: widget.staff!.id, // ✅ REQUIRED
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );

    context
        .read<StaffListBloc>()
        .add(StaffListEvent.editStaff(request));

    Navigator.pop(context);
  },
  child: const Text('Save'),
),


            ],
          ),
        ],
      ),
    );
  }
}
