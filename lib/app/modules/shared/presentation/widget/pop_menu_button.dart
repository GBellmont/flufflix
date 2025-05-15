import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/injection/injections.dart';

import 'package:flufflix/app/modules/shared/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/event/events.dart';
import 'package:flufflix/app/modules/shared/presentation/state/states.dart';
import 'package:flufflix/app/modules/shared/presentation/widget/widgets.dart';

class PopMenuButton extends StatefulWidget {
  final String id;
  final String title;
  final String posterImage;
  final String releaseYear;
  final ContentTypeEnum type;
  final List<PopMenuOptionsTypeEnum> options;
  final void Function()? onActionCompleted;

  const PopMenuButton(
      {super.key,
      required this.id,
      required this.title,
      required this.posterImage,
      required this.type,
      required this.releaseYear,
      required this.options,
      this.onActionCompleted});

  @override
  State<StatefulWidget> createState() => _PopMenuButtonState();
}

class _PopMenuButtonState extends State<PopMenuButton> {
  late final PopMenuOptionsBloc _popMenuOptionsBloc;
  late final StreamSubscription<PopMenuOptionsState> _popMenuOptionsStateSub;

  @override
  void initState() {
    _popMenuOptionsBloc = getIt.get<PopMenuOptionsBloc>();
    _popMenuOptionsStateSub =
        _popMenuOptionsBloc.stream.listen(popMenuOptionsStateListener);

    _popMenuOptionsBloc
        .add(VerifyOptionsStateEvent(id: widget.id, options: widget.options));

    super.initState();
  }

  @override
  void dispose() {
    _popMenuOptionsStateSub.cancel();
    _popMenuOptionsBloc.close();

    super.dispose();
  }

  void popMenuOptionsStateListener(PopMenuOptionsState state) {
    if (state is PopMenuOptionsErrorState) {
      _popMenuOptionsBloc
          .add(VerifyOptionsStateEvent(id: widget.id, options: widget.options));

      ScaffoldMessenger.of(context).showSnackBar(
          StyledSnackBar(text: state.message, type: StyledSnackBarType.error));
    }

    if (state is PopMenuOptionsSuccessState) {
      widget.onActionCompleted.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopMenuOptionsBloc, PopMenuOptionsState>(
        bloc: _popMenuOptionsBloc,
        builder: (context, state) => switch (state) {
              PopMenuOptionsSuccessState(options: var options) =>
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onSelected: (value) {
                    final option =
                        options.firstWhere((item) => item.type.value == value);

                    _popMenuOptionsBloc.add(ExecuteOptionActionEvent(
                        id: widget.id,
                        title: widget.title,
                        posterImage: widget.posterImage,
                        releaseYear: widget.releaseYear,
                        type: widget.type,
                        activate: !option.isActive,
                        typeToExecuteAction: option.type,
                        options: widget.options));
                  },
                  itemBuilder: (context) {
                    return options
                        .map((element) => PopupMenuItem(
                              value: element.type.value,
                              child: Text(
                                element.isActive
                                    ? element.type.inverseText
                                    : element.type.text,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ))
                        .toList();
                  },
                ),
              _ => _PopMenuLoading(),
            });
  }
}

class _PopMenuLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
      ),
    );
  }
}
