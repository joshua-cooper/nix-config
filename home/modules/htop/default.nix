{
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = 1;
      hide_userland_threads = 1;
      tree_view = 1;
      show_program_path = 0;
      cpu_count_from_one = 1;
    };
  };
}
