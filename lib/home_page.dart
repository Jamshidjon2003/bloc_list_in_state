import 'package:bloc_list_in_state/bloc/note_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Notes"),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(builder: (_, state) {
        return ListView.separated(
            itemBuilder: (_, index) =>
                ListTile(
                  onTap: (){
                    _controller.text=state.notes[index];

                    showDialog(context: context, builder: (_) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(

                                  controller: _controller),
                              const SizedBox(height: 16,),
                              ElevatedButton(onPressed: () {
                                context.read<NoteBloc>()
                                    .add(NoteUpdateEvent(index: index, note: _controller.text.trim()));
                                _controller.clear();
                                Navigator.pop(context);
                              }, child: const Text("ADD"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    );

                  },
                  title: Text(
                    state.notes[index],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context
                          .read<NoteBloc>()
                          .add(NoteRemoveEvent(index: index));
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: state.notes.length);
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) {
            return Dialog(
              insetPadding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(

                        controller: _controller),
                    const SizedBox(height: 16,),
                    ElevatedButton(onPressed: () {
                      context.read<NoteBloc>()
                          .add(NoteAddEvent(note: _controller.text.trim()));
                      _controller.clear();
                      Navigator.pop(context);
                    }, child: const Text("ADD"),
                    )
                  ],
                ),
              ),
            );
          },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
